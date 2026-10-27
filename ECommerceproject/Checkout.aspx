<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="ECommerceproject.Checkout" ResponseEncoding="utf-8" %>
<!doctype html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Review your FlipShop delivery details, cart, payment option, and order total." />
    <title>Checkout | FlipShop</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css2?family=Figtree:wght@400;500;600;700&amp;family=Outfit:wght@600;700&amp;display=swap" rel="stylesheet" />
    <style>
        :root {
            --primary: #008ecc;
            --primary-hover: #007eb5;
            --nav: #0c5273;
            --action: #f97316;
            --action-hover: #ea580c;
            --success: #2f9e44;
            --success-soft: #eaf9ed;
            --page: #f8fafc;
            --surface: #ffffff;
            --subtle: #f8fafc;
            --border: #e5e7eb;
            --text: #1f2937;
            --muted: #64748b;
            --shadow-sm: 0 1px 2px rgba(15, 23, 42, .06), 0 1px 3px rgba(15, 23, 42, .08);
            --shadow-md: 0 8px 22px rgba(15, 23, 42, .08);
        }
        * { box-sizing: border-box; }
        html { color-scheme: light; }
        body { margin: 0; min-width: 320px; overflow-x: hidden; background: var(--page); color: var(--text); font-family: "Figtree", Arial, sans-serif; }
        button, input, textarea { font: inherit; }
        a { color: inherit; text-decoration: none; }
        .icon { width: 22px; height: 22px; display: block; }
        .site-header { background: var(--primary); color: #fff; box-shadow: var(--shadow-sm); }
        .header-inner { max-width: 1180px; margin: 0 auto; display: grid; grid-template-columns: auto minmax(0, 1fr) auto; align-items: center; gap: 20px; padding: 12px 24px; }
        .brand-wrap, .header-actions, .brand-link, .icon-button { display: flex; align-items: center; }
        .brand-wrap { gap: 10px; }
        .brand-link { font: 700 24px/1 "Outfit", sans-serif; }
        .icon-button { position: relative; justify-content: center; width: 40px; height: 40px; padding: 0; border: 0; border-radius: 9px; background: transparent; color: inherit; cursor: pointer; transition: background-color .18s ease; }
        .icon-button:hover { background: rgba(255,255,255,.14); }
        .search-box { height: 42px; display: flex; align-items: center; gap: 10px; padding: 0 14px; border-radius: 9px; background: #fff; box-shadow: 0 0 0 1px rgba(255,255,255,.24); }
        .search-box svg { color: var(--primary); flex: 0 0 auto; }
        .search-box input { min-width: 0; width: 100%; border: 0; outline: 0; background: transparent; color: var(--text); font-size: 14px; }
        .search-box input::placeholder { color: #94a3b8; }
        .header-actions { gap: 4px; }
        .cart-count { position: absolute; top: 1px; right: 0; display: grid; place-items: center; min-width: 17px; height: 17px; padding: 0 4px; border-radius: 999px; background: var(--action); color: #fff; font-size: 10px; font-weight: 700; }
        .mobile-search { display: none; }
        .category-nav { background: var(--nav); color: #fff; }
        .category-inner { max-width: 1180px; margin: 0 auto; display: flex; padding: 0 24px; }
        .category-link { padding: 11px 22px; font-size: 13px; font-weight: 600; transition: background-color .18s ease; }
        .category-link:first-child { padding-left: 0; }
        .category-link:hover { background: rgba(255,255,255,.08); }
        .drawer-backdrop { position: fixed; inset: 0; z-index: 100; visibility: hidden; opacity: 0; background: rgba(15,23,42,.42); transition: opacity .18s ease, visibility .18s ease; }
        .drawer-backdrop.open { visibility: visible; opacity: 1; }
        .drawer { width: min(84vw, 320px); height: 100%; transform: translateX(-100%); background: #fff; box-shadow: var(--shadow-md); transition: transform .2s ease; }
        .drawer-backdrop.open .drawer { transform: translateX(0); }
        .drawer-head { display: flex; align-items: center; justify-content: space-between; padding: 14px 16px; background: var(--primary); color: #fff; }
        .drawer-title { font: 700 20px/1 "Outfit", sans-serif; }
        .drawer-body { padding: 18px 16px; }
        .drawer-label { margin: 0 0 8px; color: var(--muted); font-size: 11px; font-weight: 700; text-transform: uppercase; }
        .drawer-link { display: block; padding: 13px 2px; border-bottom: 1px solid var(--border); color: var(--text); font-size: 14px; font-weight: 600; }
        .page-shell { max-width: 1200px; margin: 0 auto; padding: 30px 24px 64px; }
        .page-intro { display: flex; align-items: flex-end; justify-content: space-between; gap: 16px; margin-bottom: 22px; }
        .eyebrow { margin: 0 0 5px; color: var(--primary); font-size: 11px; font-weight: 700; text-transform: uppercase; }
        h1 { margin: 0; color: var(--nav); font: 700 30px/1.15 "Outfit", sans-serif; }
        .intro-copy { margin: 7px 0 0; color: var(--muted); font-size: 14px; }
        .item-pill { flex: 0 0 auto; margin-bottom: 2px; padding: 7px 12px; border: 1px solid var(--border); border-radius: 999px; background: #fff; color: var(--muted); font-size: 12px; font-weight: 600; }
        .steps { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); margin: 0; padding: 0; overflow: hidden; border: 1px solid var(--border); border-radius: 12px; background: #fff; box-shadow: var(--shadow-sm); list-style: none; }
        .step { display: flex; min-width: 0; align-items: center; justify-content: center; gap: 8px; padding: 14px 8px; border-right: 1px solid var(--border); }
        .step:last-child { border-right: 0; }
        .step.complete { background: var(--success-soft); }
        .step-number { display: grid; flex: 0 0 auto; width: 25px; height: 25px; place-items: center; border-radius: 50%; background: var(--nav); color: #fff; font-size: 11px; font-weight: 700; }
        .step.complete .step-number { background: var(--success); }
        .step-label { overflow: hidden; color: var(--nav); font-size: 11px; font-weight: 700; text-overflow: ellipsis; text-transform: uppercase; white-space: nowrap; }
        .checkout-grid { display: grid; grid-template-columns: minmax(0, 1fr) 350px; align-items: start; gap: 24px; margin-top: 24px; }
        .checkout-main { min-width: 0; display: grid; gap: 20px; }
        .checkout-card, .summary-card { overflow: hidden; border: 1px solid var(--border); border-radius: 12px; background: #fff; box-shadow: var(--shadow-sm); transition: box-shadow .18s ease; }
        .checkout-card:hover { box-shadow: var(--shadow-md); }
        .section-head { display: flex; align-items: center; justify-content: space-between; gap: 12px; padding: 14px 20px; border-bottom: 1px solid var(--border); background: var(--subtle); }
        .section-title-wrap { display: flex; min-width: 0; align-items: center; gap: 12px; }
        .section-number { display: grid; flex: 0 0 auto; width: 28px; height: 28px; place-items: center; border-radius: 50%; background: var(--nav); color: #fff; font-size: 12px; font-weight: 700; }
        .section-number.complete { background: var(--success-soft); color: var(--success); }
        .section-title { margin: 0; overflow: hidden; color: var(--nav); font: 600 16px/1.2 "Outfit", sans-serif; text-overflow: ellipsis; white-space: nowrap; }
        .complete-pill { padding: 5px 10px; border-radius: 999px; background: var(--success-soft); color: var(--success); font-size: 11px; font-weight: 700; }
        .section-body { padding: 24px; }
        .info-row { display: grid; grid-template-columns: 74px minmax(0, 1fr); gap: 12px; margin-bottom: 12px; font-size: 14px; }
        .info-label { color: var(--muted); }
        .info-value { min-width: 0; font-weight: 600; }
        .account-link { display: inline-block; margin-top: 2px; color: var(--primary); font-size: 14px; font-weight: 600; }
        .account-link:hover { color: var(--primary-hover); }
        .button-row { display: flex; flex-wrap: wrap; justify-content: flex-end; gap: 10px; margin-top: 20px; padding-top: 20px; border-top: 1px solid var(--border); }
        .button-row.start { justify-content: flex-start; padding-top: 0; border-top: 0; }
        .btn { display: inline-flex; min-height: 42px; align-items: center; justify-content: center; border: 1px solid transparent; border-radius: 8px; padding: 0 20px; cursor: pointer; font-size: 12px; font-weight: 700; text-transform: uppercase; transition: transform .16s ease, background-color .16s ease, border-color .16s ease, box-shadow .16s ease; }
        .btn:hover { transform: translateY(-1px); }
        .btn:focus-visible, .icon-button:focus-visible, input:focus-visible, textarea:focus-visible { outline: 3px solid rgba(0,142,204,.22); outline-offset: 2px; }
        .btn-action { background: var(--action); color: #fff; box-shadow: 0 5px 12px rgba(249,115,22,.16); }
        .btn-action:hover { background: var(--action-hover); }
        .btn-outline { border-color: #9bd8ef; background: #fff; color: var(--primary); }
        .btn-outline:hover { border-color: var(--primary); background: #f4fbfe; }
        .login-layout { display: grid; grid-template-columns: minmax(0, 1fr) auto; align-items: start; gap: 20px; }
        .verified { display: inline-flex; align-items: center; gap: 6px; padding: 6px 10px; border-radius: 999px; background: var(--success-soft); color: var(--success); font-size: 11px; font-weight: 700; }
        .address-summary { display: grid; grid-template-columns: minmax(0, 1fr) auto; align-items: start; gap: 16px; }
        .address-content { display: flex; min-width: 0; gap: 12px; }
        .address-icon, .choice-icon, .pay-icon { display: grid; flex: 0 0 auto; place-items: center; border-radius: 9px; background: var(--success-soft); color: var(--success); }
        .address-icon { width: 38px; height: 38px; }
        .address-name { display: flex; flex-wrap: wrap; align-items: center; gap: 7px; margin: 0; font-weight: 700; }
        .check { display: inline-grid; width: 18px; height: 18px; place-items: center; color: var(--success); }
        .check-icon { width: 15px; height: 15px; display: block; fill: none; stroke: currentColor; stroke-width: 2.5; stroke-linecap: round; stroke-linejoin: round; }
        .step-number .check-icon, .section-number .check-icon { width: 14px; height: 14px; }
        .btn-confirmed, .btn-confirmed:hover { background: var(--success); color: #fff; box-shadow: none; transform: none; cursor: default; }
        .btn-confirmed::before { content: "\2713"; margin-right: 7px; font-size: 15px; line-height: 1; }
        .checkout-card.is-complete .section-head { background: var(--success-soft); }
        .checkout-card.is-complete .section-number { background: var(--success); color: #fff; }
        .checkout-card.is-complete .complete-pill { display: inline-block; }
        .address-line { margin: 6px 0 0; color: #475569; font-size: 14px; line-height: 1.65; }
        .address-contact { margin: 7px 0 0; overflow-wrap: anywhere; color: var(--muted); font-size: 13px; }
        .option-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 12px; }
        .option-button { width: 100%; min-height: 74px; display: flex; align-items: center; gap: 12px; padding: 14px; border: 1px solid var(--border); border-radius: 9px; background: #fff; color: var(--text); cursor: pointer; text-align: left; transition: transform .16s ease, border-color .16s ease, box-shadow .16s ease; }
        .option-button:hover { transform: translateY(-1px); border-color: #9bd8ef; box-shadow: var(--shadow-sm); }
        .choice-icon { width: 38px; height: 38px; background: #eaf7fc; color: var(--primary); }
        .option-title { display: block; font-size: 12px; font-weight: 700; text-transform: uppercase; }
        .option-copy { display: block; margin-top: 3px; color: var(--muted); font-size: 12px; }
        .form-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 16px; }
        .field.full { grid-column: 1 / -1; }
        .field label { display: block; margin-bottom: 7px; color: var(--text); font-size: 13px; font-weight: 700; }
        .field input, .field textarea { width: 100%; border: 1px solid #cbd5e1; border-radius: 9px; padding: 11px 13px; background: var(--subtle); color: var(--text); outline: 0; transition: border-color .16s ease, background-color .16s ease, box-shadow .16s ease; }
        .field input:focus, .field textarea:focus { border-color: var(--primary); background: #fff; box-shadow: 0 0 0 3px rgba(0,142,204,.12); }
        .field textarea { min-height: 94px; resize: vertical; }
        .product-list { display: grid; }
        .cart-item { display: grid; grid-template-columns: 92px minmax(0, 1fr) auto; align-items: center; gap: 16px; padding: 20px 0; border-bottom: 1px solid var(--border); }
        .cart-item:first-child { padding-top: 0; }
        .cart-item:last-child { padding-bottom: 0; border-bottom: 0; }
        .product-image { width: 92px; height: 92px; display: grid; place-items: center; overflow: hidden; border: 1px solid var(--border); border-radius: 9px; background: var(--subtle); }
        .product-image img { width: 100%; height: 100%; object-fit: contain; }
        .product-name { margin: 0; font-size: 15px; font-weight: 700; line-height: 1.4; }
        .product-price { margin: 8px 0 0; color: var(--nav); font: 700 16px/1 "Outfit", sans-serif; }
        .quantity { padding: 6px 11px; border: 1px solid var(--border); border-radius: 999px; background: var(--subtle); color: var(--muted); font-size: 11px; font-weight: 700; }
        .empty-cart { margin: 0; color: var(--muted); font-size: 14px; }
        .payment-options { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 12px; }
        .payment-choice { position: relative; display: grid; grid-template-columns: auto minmax(0, 1fr) auto; align-items: center; gap: 12px; min-height: 68px; padding: 14px; border: 1px solid var(--border); border-radius: 9px; background: #fff; cursor: pointer; transition: border-color .16s ease, background-color .16s ease, box-shadow .16s ease; }
        .payment-choice:has(input:checked) { border-color: var(--primary); background: #eaf7fc; box-shadow: var(--shadow-sm); }
        .payment-choice input { position: absolute; inset: 0; width: 100%; height: 100%; margin: 0; cursor: pointer; opacity: 0; }
        .pay-icon { width: 38px; height: 38px; background: #fff; color: var(--primary); box-shadow: var(--shadow-sm); }
        .payment-label { min-width: 0; font-size: 13px; font-weight: 700; }
        .radio-mark { width: 20px; height: 20px; display: grid; place-items: center; border: 2px solid #cbd5e1; border-radius: 50%; }
        .payment-choice:has(input:checked) .radio-mark { border-color: var(--primary); background: var(--primary); }
        .payment-choice:has(input:checked) .radio-mark::after { width: 6px; height: 6px; border-radius: 50%; background: #fff; content: ""; }
        .summary-card { position: sticky; top: 20px; }
        .summary-head { padding: 17px 20px; background: var(--nav); color: #fff; }
        .summary-head h2 { margin: 0; font: 600 18px/1.2 "Outfit", sans-serif; }
        .summary-head p { margin: 5px 0 0; color: rgba(255,255,255,.72); font-size: 11px; }
        .summary-lines { margin: 0; padding: 20px; }
        .summary-row { display: flex; justify-content: space-between; gap: 18px; margin-bottom: 16px; font-size: 14px; }
        .summary-row:last-child { margin-bottom: 0; }
        .summary-row dt { color: #475569; }
        .summary-row dd { margin: 0; font-weight: 600; }
        .discount { color: var(--success); }
        .summary-total { display: flex; align-items: center; justify-content: space-between; gap: 14px; padding: 20px; border-top: 1px dashed var(--border); background: var(--subtle); color: var(--nav); font: 700 16px/1.2 "Outfit", sans-serif; }
        .summary-total strong { font-size: 24px; }
        .saving { padding: 13px 20px; border-top: 1px solid var(--border); color: var(--success); font-size: 11px; font-weight: 700; }
        @media (max-width: 900px) {
            .category-nav { display: none; }
            .checkout-grid { grid-template-columns: 1fr; }
            .summary-card { position: static; }
        }
        @media (max-width: 700px) {
            .header-inner { grid-template-columns: auto 1fr auto; gap: 7px; padding: 10px 12px; }
            .desktop-search { display: none; }
            .mobile-search { display: flex; grid-column: 1 / -1; }
            .brand-link { font-size: 21px; }
            .page-shell { padding: 22px 12px 46px; }
            h1 { font-size: 24px; }
            .intro-copy { line-height: 1.5; }
            .step-label { display: none; }
            .checkout-grid { gap: 20px; }
            .section-head { padding: 14px 16px; }
            .section-body { padding: 18px 16px; }
            .complete-pill { display: none; }
            .option-grid, .form-grid, .payment-options { grid-template-columns: 1fr; }
            .login-layout { grid-template-columns: 1fr; }
            .verified { justify-self: start; }
            .cart-item { grid-template-columns: 76px minmax(0, 1fr); gap: 14px; padding: 16px 0; }
            .product-image { width: 76px; height: 76px; }
            .quantity { grid-column: 2; justify-self: start; margin-top: -8px; }
            .button-row .btn { width: 100%; }
        }
        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after { scroll-behavior: auto !important; transition-duration: .01ms !important; }
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <header class="site-header">
        <div class="header-inner">
            <div class="brand-wrap">
                <button type="button" class="icon-button openNav" aria-label="Open navigation menu" aria-controls="siteDrawer" aria-expanded="false">
                    <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M4 6h16M4 12h16M4 18h16" /></svg>
                </button>
                <a class="brand-link" href="Home.aspx">FlipShop</a>
            </div>
            <label class="search-box desktop-search">
                <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><circle cx="11" cy="11" r="7" /><path d="m20 20-4-4" /></svg>
                <input type="search" aria-label="Search products" placeholder="Search essentials, groceries, and more..." />
            </label>
            <div class="header-actions">
                <asp:LinkButton ID="lnkLoginProfile" runat="server" OnClick="lnkLoginProfile_Click" CssClass="icon-button" aria-label="Your profile" UseSubmitBehavior="false"><svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><circle cx="12" cy="8" r="4" /><path d="M5 21a7 7 0 0 1 14 0" /></svg><asp:Literal ID="litProfileName" runat="server"></asp:Literal></asp:LinkButton>
                <a class="icon-button" href="cart.aspx" aria-label="Your cart"><svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><circle cx="9" cy="20" r="1" /><circle cx="18" cy="20" r="1" /><path d="M3 4h2l2.4 10.2a2 2 0 0 0 2 1.5h7.9a2 2 0 0 0 2-1.6L21 7H6" /></svg><span class="cart-count"><asp:Label ID="lblHeaderItemCount" runat="server">0</asp:Label></span></a>
            </div>
            <label class="search-box mobile-search">
                <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><circle cx="11" cy="11" r="7" /><path d="m20 20-4-4" /></svg>
                <input type="search" aria-label="Search products" placeholder="Search products..." />
            </label>
        </div>
    </header>

    <nav class="category-nav" aria-label="Product categories">
        <div class="category-inner">
            <a class="category-link" href="Filter.aspx">Groceries</a><a class="category-link" href="Filter.aspx">Home &amp; Kitchen</a><a class="category-link" href="Filter.aspx">Fashion</a><a class="category-link" href="Filter.aspx">Electronics</a><a class="category-link" href="Filter.aspx">Beauty</a>
        </div>
    </nav>

    <div id="siteDrawer" class="drawer-backdrop menu-section" role="presentation">
        <aside class="drawer" role="dialog" aria-modal="true" aria-label="Navigation menu">
            <div class="drawer-head"><span class="drawer-title">FlipShop</span><button type="button" class="icon-button closeNav" aria-label="Close navigation menu"><svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 6l12 12M18 6 6 18" /></svg></button></div>
            <div class="drawer-body"><p class="drawer-label">Shop categories</p><a class="drawer-link" href="Filter.aspx">Groceries</a><a class="drawer-link" href="Filter.aspx">Home &amp; Kitchen</a><a class="drawer-link" href="Filter.aspx">Fashion</a><a class="drawer-link" href="Filter.aspx">Electronics</a><a class="drawer-link" href="Filter.aspx">Beauty</a></div>
        </aside>
    </div>

    <main class="page-shell">
        <div class="page-intro">
            <div><p class="eyebrow">Secure checkout</p><h1>Complete your order</h1><p class="intro-copy">Review your details before placing the order.</p></div>
            <span class="item-pill"><asp:Label ID="lblIntroItemCount" runat="server">0</asp:Label> items</span>
        </div>

        <ol class="steps" aria-label="Checkout progress">
            <li class="step login-progress-step"><span class="step-number">1</span><span class="step-label">Login</span></li>
            <li class="step complete"><span class="step-number"><svg class="check-icon" viewBox="0 0 24 24" aria-hidden="true"><path d="m5 12 4 4L19 6" /></svg></span><span class="step-label">Delivery</span></li>
            <li class="step review-progress-step"><span class="step-number">3</span><span class="step-label">Review</span></li>
            <li class="step payment-progress-step"><span class="step-number">4</span><span class="step-label">Payment</span></li>
        </ol>

        <div class="checkout-grid">
            <div class="checkout-main">
                <section class="checkout-card login-check-section">
                    <div class="section-head"><div class="section-title-wrap"><span class="section-number">1</span><h2 class="section-title">Login</h2></div><span class="complete-pill" style="display:none">Completed</span></div>
                    <div class="section-body login-check">
                        <div class="login-layout"><div><div class="info-row"><span class="info-label">Name</span><asp:Label ID="lblLoginName" runat="server" CssClass="info-value" Text="Not signed in"></asp:Label></div><div class="info-row"><span class="info-label">Phone</span><asp:Label ID="lblLoginPhone" runat="server" CssClass="info-value"></asp:Label></div><a class="account-link" href="#">Logout &amp; sign in to another account</a></div></div>
                        <div class="button-row start"><button id="btnContinueCheckout" type="button" class="btn btn-action checkout-btn" onclick="completeLoginStep(this);">Continue Checkout</button></div>
                    </div>
                    <div class="section-body logined" style="display:none"><div class="login-layout"><div><asp:Label ID="lblLoginNameSaved" runat="server" CssClass="info-value"></asp:Label> <asp:Label ID="lblLoginPhoneSaved" runat="server"></asp:Label></div><span class="verified"><svg class="check-icon" viewBox="0 0 24 24" aria-hidden="true"><path d="m5 12 4 4L19 6" /></svg>Verified</span></div><div class="button-row"><asp:Button ID="btnChangeLogin" runat="server" Text="Change" CssClass="btn btn-outline login-change-btn" /></div></div>
                </section>

                <section class="checkout-card address-section">
                    <div class="section-head"><div class="section-title-wrap"><span class="section-number complete"><svg class="check-icon" viewBox="0 0 24 24" aria-hidden="true"><path d="m5 12 4 4L19 6" /></svg></span><h2 class="section-title">Delivery Address</h2></div><span class="complete-pill">Completed</span></div>
                    <asp:Panel ID="pnlDeliverySaved" runat="server" CssClass="section-body address-summary">
                        <div class="address-content"><span class="address-icon"><svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 10c0 5-8 11-8 11S4 15 4 10a8 8 0 1 1 16 0Z" /><circle cx="12" cy="10" r="2.5" /></svg></span><div><p class="address-name"><asp:Label ID="lblAddressNameSaved" runat="server"></asp:Label><span class="check"><svg class="check-icon" viewBox="0 0 24 24" aria-label="Selected"><path d="m5 12 4 4L19 6" /></svg></span></p><p class="address-line"><asp:Label ID="lblAddressFullSaved" runat="server"></asp:Label></p><p class="address-contact"><asp:Label ID="lblAddressPhoneSaved" runat="server"></asp:Label> &middot; <asp:Label ID="lblAddressEmailSaved" runat="server"></asp:Label></p></div></div>
                        <asp:Button ID="btnChangeAddress" runat="server" Text="Change" OnClick="btnChangeAddress_Click" CssClass="btn btn-outline" />
                    </asp:Panel>
                    <asp:Panel ID="pnlDeliveryOptions" runat="server" Visible="false" CssClass="section-body">
                        <div class="option-grid">
                            <asp:LinkButton ID="btnAddAddressOption" runat="server" OnClick="btnAddAddressOption_Click" CssClass="option-button"><span class="choice-icon"><svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 5v14M5 12h14" /></svg></span><span><span class="option-title">Add New Address</span><span class="option-copy">Use another delivery location</span></span></asp:LinkButton>
                            <asp:LinkButton ID="btnEditDetailsOption" runat="server" OnClick="btnEditDetailsOption_Click" CssClass="option-button"><span class="choice-icon"><svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4" /><path d="M5 21a7 7 0 0 1 14 0" /></svg></span><span><span class="option-title">Edit Details</span><span class="option-copy">Update name, phone or email</span></span></asp:LinkButton>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="pnlAddNewAddress" runat="server" Visible="false" CssClass="section-body">
                        <div class="form-grid"><div class="field full"><label for="txtAddress">Address</label><asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" placeholder="Flat/House No. Colony/Street No."></asp:TextBox></div></div>
                        <div class="button-row"><asp:Button ID="btnSaveTempAddress" runat="server" Text="Save and Continue" OnClick="btnSaveTempAddress_Click" CssClass="btn btn-action" /></div>
                    </asp:Panel>
                    <asp:Panel ID="pnlEditDetails" runat="server" Visible="false" CssClass="section-body">
                        <div class="form-grid"><div class="field"><label for="txtName">Name</label><asp:TextBox ID="txtName" runat="server" placeholder="Full Name"></asp:TextBox></div><div class="field"><label for="txtMobile">Phone</label><asp:TextBox ID="txtMobile" runat="server" TextMode="Phone" placeholder="Mobile Number"></asp:TextBox></div><div class="field full"><label for="txtEmail">Email</label><asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="Email"></asp:TextBox></div></div>
                        <div class="button-row"><asp:Button ID="btnSaveDetails" runat="server" Text="Save and Continue" OnClick="btnSaveDetails_Click" CssClass="btn btn-action" /></div>
                    </asp:Panel>
                </section>

                <section class="checkout-card review-cart-section">
                    <div class="section-head"><div class="section-title-wrap"><span class="section-number">3</span><h2 class="section-title">Review Order</h2></div><span class="complete-pill" style="display:none">Completed</span></div>
                    <div class="section-body review-cart">
                        <div class="product-list"><asp:Repeater ID="rptReviewCart" runat="server"><ItemTemplate><article class="cart-item"><div class="product-image"><img src='<%# ResolveUrl(string.IsNullOrEmpty(Convert.ToString(Eval("Image"))) ? "~/ProductPhotos/placeholder.jpg" : Convert.ToString(Eval("Image"))) %>' alt='<%# Eval("ProductName") %>' /></div><div><h3 class="product-name"><%# Eval("ProductName") %></h3><p class="product-price">&#8377;<%# Eval("Price", "{0:0.00}") %></p></div><span class="quantity">Qty: <%# Eval("Quantity") %></span></article></ItemTemplate></asp:Repeater></div>
                        <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false"><p class="empty-cart">Your cart is empty.</p></asp:Panel>
                        <div class="button-row"><button id="btnContinueCart" type="button" class="btn btn-action save-cart-btn" onclick="completeReviewStep(this);">Continue</button></div>
                    </div>
                    <div class="section-body cartSave" style="display:none"><div class="login-layout"><asp:Label ID="lblReviewItemCount" runat="server" CssClass="info-value"></asp:Label><span class="verified"><svg class="check-icon" viewBox="0 0 24 24" aria-hidden="true"><path d="m5 12 4 4L19 6" /></svg>Reviewed</span></div><div class="button-row"><asp:Button ID="btnChangeCart" runat="server" Text="Change" CssClass="btn btn-outline cart-change-btn" /></div></div>
                </section>

                <section class="checkout-card payments-section">
                    <div class="section-head"><div class="section-title-wrap"><span class="section-number">4</span><h2 class="section-title">Payment Option</h2></div><span class="complete-pill" style="display:none">Completed</span></div>
                    <div class="section-body paymen-option">
                        <div class="payment-options">
                            <label class="payment-choice"><input type="radio" name="flexRadioDefault" id="flexRadioDefault1" value="cash" /><span class="pay-icon"><svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="5" width="18" height="14" rx="2" /><path d="M7 10h10M7 14h5" /></svg></span><span class="payment-label">Cash On Delivery</span><span class="radio-mark"></span></label>
                            <label class="payment-choice"><input type="radio" name="flexRadioDefault" id="flexRadioDefault2" value="online" checked="checked" /><span class="pay-icon"><svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="5" width="18" height="14" rx="2" /><path d="M3 10h18" /></svg></span><span class="payment-label">Online</span><span class="radio-mark"></span></label>
                        </div>
                        <div class="button-row"><asp:Button ID="btnConfirmOrder" runat="server" Text="Confirm Order" OnClick="btnConfirmOrder_Click" CssClass="btn btn-action" /></div>
                    </div>
                </section>
            </div>

            <aside class="summary-card">
                <div class="summary-head"><h2>Payment Summary</h2><p>All prices include applicable taxes</p></div>
                <dl class="summary-lines"><div class="summary-row"><dt>Price (<asp:Label ID="lblItemCount" runat="server">0</asp:Label> items)</dt><dd>&#8377;<asp:Label ID="lblSubTotal" runat="server">0.00</asp:Label></dd></div><div class="summary-row"><dt>Discount</dt><dd class="discount">&minus; &#8377;22</dd></div><div class="summary-row"><dt>Delivery Charges</dt><dd>&#8377;40</dd></div></dl>
                <div class="summary-total"><span>Total Amount</span><strong>&#8377;<asp:Label ID="lblGrandTotal" runat="server">0.00</asp:Label></strong></div>
                <div class="saving"><svg class="check-icon" viewBox="0 0 24 24" aria-hidden="true" style="display:inline-block;vertical-align:-3px;margin-right:5px"><path d="m5 12 4 4L19 6" /></svg>Your discount has been applied</div>
            </aside>
        </div>
    </main>

    <script>
        var CHECK_SVG = '<svg class="check-icon" viewBox="0 0 24 24" aria-hidden="true"><path d="m5 12 4 4L19 6"></path></svg>';
        function completeStep(button, sectionSelector, stepSelector, label) {
            var section = document.querySelector(sectionSelector);
            var progressStep = document.querySelector(stepSelector);
            if (button) {
                if (button.tagName === 'INPUT') { button.value = label; }
                else { button.textContent = label; }
                button.classList.add('btn-confirmed');
                button.setAttribute('aria-disabled', 'true');
                button.disabled = true;
            }
            if (section) {
                section.classList.add('is-complete');
                var number = section.querySelector('.section-number');
                var pill = section.querySelector('.complete-pill');
                if (number) number.innerHTML = CHECK_SVG;
                if (pill) pill.style.display = '';
            }
            if (progressStep) {
                progressStep.classList.add('complete');
                var progressNumber = progressStep.querySelector('.step-number');
                if (progressNumber) progressNumber.innerHTML = CHECK_SVG;
            }
            return false;
        }
        function completeLoginStep(button) {
            return completeStep(button, '.login-check-section', '.login-progress-step', 'Login Confirmed');
        }
        function completeReviewStep(button) {
            return completeStep(button, '.review-cart-section', '.review-progress-step', 'Order Reviewed');
        }
        /* Bind after the page is ready without relying on legacy site scripts. */
        function bindProgressButton(id, handler) {
            var button = document.getElementById(id);
            if (!button || button.getAttribute('data-progress-bound') === 'true') return;
            button.setAttribute('data-progress-bound', 'true');
            button.addEventListener('click', function (event) {
                event.preventDefault();
                event.stopImmediatePropagation();
                handler(button);
            }, true);
        }
        function bindCheckoutProgress() {
            bindProgressButton('btnContinueCheckout', completeLoginStep);
            bindProgressButton('btnContinueCart', completeReviewStep);
        }
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', bindCheckoutProgress);
        } else {
            bindCheckoutProgress();
        }

        (function () {
            var backdrop = document.getElementById('siteDrawer');
            var openButton = document.querySelector('.openNav');
            var closeButton = document.querySelector('.closeNav');
            function setDrawer(open) {
                if (!backdrop || !openButton) return;
                backdrop.classList.toggle('open', open);
                openButton.setAttribute('aria-expanded', open ? 'true' : 'false');
                document.body.style.overflow = open ? 'hidden' : '';
            }
            if (openButton) openButton.addEventListener('click', function () { setDrawer(true); });
            if (closeButton) closeButton.addEventListener('click', function () { setDrawer(false); });
            if (backdrop) backdrop.addEventListener('click', function (event) { if (event.target === backdrop) setDrawer(false); });
            document.addEventListener('keydown', function (event) { if (event.key === 'Escape') setDrawer(false); });
        }());
    </script>
</form>
</body>
</html>
