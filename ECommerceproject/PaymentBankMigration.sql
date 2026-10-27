SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;

    IF OBJECT_ID(N'dbo.User_Reg', N'U') IS NULL OR OBJECT_ID(N'dbo.Bank', N'U') IS NULL
        THROW 51000, 'Expected dbo.User_Reg and dbo.Bank tables were not found.', 1;
    IF COL_LENGTH(N'dbo.User_Reg', N'user id') IS NULL OR COL_LENGTH(N'dbo.Bank', N'user_id') IS NULL OR COL_LENGTH(N'dbo.Bank', N'Balance') IS NULL
        THROW 51001, 'Expected user ID or Balance columns were not found.', 1;

    -- Report the exact pre-migration customer balance and successful payment history.
    SELECT u.[user id], b.Balance AS CurrentBalance
    FROM dbo.User_Reg AS u
    LEFT JOIN dbo.Bank AS b ON b.user_id = u.[user id]
    WHERE u.[user id] IN (1001, 1002, 1003)
    ORDER BY u.[user id];

    SELECT COUNT_BIG(*) AS SuccessfulPaymentCount,
           COALESCE(SUM(p.Amount), 0) AS SuccessfulPaymentAmount,
           MIN(p.PaymentDate) AS FirstSuccessfulPayment,
           MAX(p.PaymentDate) AS LastSuccessfulPayment
    FROM dbo.Payment AS p
    WHERE p.user_id = 1001 AND p.Status = N'Success';

    IF EXISTS (SELECT 1 FROM dbo.Bank GROUP BY user_id HAVING COUNT_BIG(*) > 1)
        THROW 51002, 'Duplicate Bank.user_id rows exist. Resolve duplicates without changing balances, then rerun.', 1;

    IF NOT EXISTS (SELECT 1 FROM dbo.Bank WHERE user_id=1001 AND Balance=24159.00)
        THROW 51003, 'User 1001 does not have the expected existing 24159.00 balance. No initialization was applied.', 1;

    IF NOT EXISTS
    (
        SELECT 1
        FROM sys.indexes AS i
        WHERE i.object_id = OBJECT_ID(N'dbo.Bank') AND i.is_unique = 1
          AND (SELECT COUNT(*) FROM sys.index_columns AS ic WHERE ic.object_id=i.object_id AND ic.index_id=i.index_id AND ic.key_ordinal > 0) = 1
          AND EXISTS (SELECT 1 FROM sys.index_columns AS ic JOIN sys.columns AS c ON c.object_id=ic.object_id AND c.column_id=ic.column_id WHERE ic.object_id=i.object_id AND ic.index_id=i.index_id AND ic.key_ordinal=1 AND c.name=N'user_id')
    )
        CREATE UNIQUE INDEX UX_Bank_user_id ON dbo.Bank(user_id);

    INSERT INTO dbo.Bank(user_id, Balance)
    SELECT u.[user id], CONVERT(decimal(18,2), 25000.00)
    FROM dbo.User_Reg AS u
    WHERE NOT EXISTS (SELECT 1 FROM dbo.Bank AS b WHERE b.user_id=u.[user id]);

    -- Verify requested users after insertion. Existing balances are never updated.
    SELECT u.[user id], b.Balance AS CurrentBalance
    FROM dbo.User_Reg AS u
    LEFT JOIN dbo.Bank AS b ON b.user_id = u.[user id]
    WHERE u.[user id] IN (1001, 1002, 1003)
    ORDER BY u.[user id];

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF XACT_STATE() <> 0 ROLLBACK TRANSACTION;
    THROW;
END CATCH;

