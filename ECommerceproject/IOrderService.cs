using System.Collections.Generic;
using System.Runtime.Serialization;
using System.ServiceModel;
using System;

namespace ECommerceproject
{
    // ---------------------------------------------------------------
    // Service Contract
    // ---------------------------------------------------------------
    [ServiceContract]
    public interface IOrderService
    {
        [OperationContract]
        OrderResult PlaceOrder(int userId, decimal totalAmount, string paymentMethod,
                               List<CartItemDto> items, string requestKey, string authenticationTicket);
    }

    // ---------------------------------------------------------------
    // DTO: represents one item from Session["Cart"] DataTable
    // ---------------------------------------------------------------
    [DataContract]
    public class CartItemDto
    {
        [DataMember]
        public int ProductId { get; set; }

        [DataMember]
        public string ProductName { get; set; }

        [DataMember]
        public int Quantity { get; set; }

        [DataMember]
        public decimal Price { get; set; }
    }

    // ---------------------------------------------------------------
    // DTO: result returned to the caller after PlaceOrder
    // ---------------------------------------------------------------
    [DataContract]
    public class OrderResult
    {
        [DataMember]
        public bool Success { get; set; }

        [DataMember]
        public int OrderId { get; set; }

        [DataMember]
        public string TransactionId { get; set; }

        [DataMember]
        public string Message { get; set; }
        [DataMember]
        public decimal FinalBalance { get; set; }
        [DataMember]
        public decimal PaidAmount { get; set; }
        [DataMember]
        public DateTime PaymentDate { get; set; }
        [DataMember]
        public string PaymentMethod { get; set; }
    }
}
