# FlipShop : E-Commerce Web Application

A web-based shopping application built with **ASP.NET Web Forms, C#, SQL Server, and Windows Communication Foundation (WCF)**. The project demonstrates an end-to-end shopping workflow, from browsing products and managing a cart to simulated payment processing and order confirmation.

> **Payment note:** The Demo Bank option uses a simulated balance maintained in the project database. It does not process real money. UPI and card options are UI placeholders unless separately integrated with a payment provider.

## Features

### Customer
- User registration and login
- Browse product categories and product details
- Add products to a shopping cart and review quantities
- Checkout with an order summary, discount, and delivery charge
- Simulated Demo Bank payment with balance validation and deduction
- Payment history and transaction reference details
- Order-success page with confirmation details and animation
- Submit feedback through the contact/feedback form

### Admin and Feedback Management
- Manage product and category information
- Review customer feedback in the admin workspace
- Store feedback and replies in SQL Server
- Send feedback notifications/replies through the configured email service

### Backend and Transaction Handling
- SQL Server persistence for users, products, carts, orders, payments, and feedback
- WCF-based order-processing service
- Server-side recalculation and validation of order totals
- Transactional order creation, cart archival, balance deduction, and payment-record insertion
- Insufficient-balance handling and rollback on transaction failure
- Session-backed checkout context and protection against duplicate payment submissions

## Technology Stack

| Area | Technology |
|---|---|
| Frontend | HTML, CSS, JavaScript, ASP.NET Web Forms |
| Backend | C# and .NET Framework |
| Database | Microsoft SQL Server |
| Data Access | ADO.NET / `System.Data.SqlClient` |
| Service Layer | Windows Communication Foundation (WCF) |
| Email | SMTP through the project's email service |
| IDE | Visual Studio |

## Application Flow

```text
Register / Login
      |
      v
Browse Products -> Product Details -> Shopping Cart
                                      |
                                      v
                                   Checkout
                                      |
                                      v
                              Payment.aspx
                                      |
                                      v
                               WCF OrderService
                                      |
                     Validate order and available balance
                                      |
                     +----------------+----------------+
                     |                                 |
                  Failure                            Success
                     |                                 |
             Keep cart and show                 SQL transaction:
             an error message                  - Create Order
                                               - Archive cart items
                                               - Deduct Bank balance
                                               - Create Payment record
                                                      |
                                                      v
                                               OrderSuccess.aspx
```
Built as a learning project to explore full-stack web development with ASP.NET Web Forms, SQL Server, and WCF.

Author
Abin T Abey
