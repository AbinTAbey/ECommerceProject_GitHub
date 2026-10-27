<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="user.aspx.cs" Inherits="ECommerceproject.user" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="./assets/css/output.css" rel="stylesheet">
  <link href="./assets/css/custom.css" rel="stylesheet" />
  <link href="./assets/css/owlcarousel/owl.carousel.min.css" rel="stylesheet">
  <link href="./assets/css/owlcarousel/owl.theme.default.min.css" rel="stylesheet">
  <title>Login Page</title>
    <style type="text/css">
   
        .reg-page-wrap {
            width: 100%;
            display: flex;
            justify-content: center;
            padding: 40px 16px 40px 16px;
            box-sizing: border-box;
        }
      /*  @media (max-width: 1023px) {
   
    .reg-page-wrap {
        padding-top: 96px;
    }
}*/
        .reg-card {
            width: 100%;
            max-width: 440px;
            background-color: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            box-shadow: 0 4px 24px rgba(15, 23, 42, 0.07);
            padding: 36px 32px;
            box-sizing: border-box;
        }

        .reg-card-header {
            text-align: center;
            margin-bottom: 26px;
        }

        .reg-card-header h1 {
            font-size: 21px;
            line-height: 1.3;
            font-weight: 700;
            color: #1f2937;
            margin: 0;
        }

        .reg-card-header p {
            font-size: 13px;
            color: #6b7280;
            margin: 6px 0 0 0;
        }

        .reg-row {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 9px 0;
            border-bottom: 1px solid #f3f4f6;
        }

        .reg-row:first-of-type {
            padding-top: 0;
        }

        .reg-label {
            flex: 0 0 128px;
            font-size: 13px;
            font-weight: 600;
            color: #374151;
        }

        .reg-input {
            display: block;
            flex: 1 1 auto;
            width: 100%;
            min-width: 0;
            padding: 9px 12px;
            font-size: 14px;
            line-height: 1.4;
            color: #1f2937;
            background-color: #fbfcfd;
            border: 1px solid #dbe1e8;
            border-radius: 8px;
            box-sizing: border-box;
            transition: border-color 0.15s ease, box-shadow 0.15s ease, background-color 0.15s ease;
        }

        .reg-input::placeholder {
            color: #9ca3af;
        }

        .reg-input:focus {
            outline: none;
            background-color: #ffffff;
            border-color: #008ECC;
            box-shadow: 0 0 0 3px rgba(0, 142, 204, 0.15);
        }

        .reg-actions {
            margin-top: 22px;
        }

        .reg-submit-btn {
            display: block;
            width: 100%;
            padding: 11px 16px;
            background-color: #008ECC;
            color: #ffffff;
            font-weight: 600;
            font-size: 14px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.15s ease, transform 0.05s ease;
        }

        .reg-submit-btn:hover {
            background-color: #0077ab;
        }

        .reg-submit-btn:active {
            transform: scale(0.99);
        }

        .reg-submit-btn:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(0, 142, 204, 0.25);
        }

        .reg-status {
            display: block;
            width: 100%;
            box-sizing: border-box;
            margin-top: 16px;
            padding: 10px 14px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 500;
            text-align: center;
            background-color: #eff6ff;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }

        @media (max-width: 480px) {
            .reg-card {
                padding: 28px 20px;
            }

            .reg-row {
                flex-direction: column;
                align-items: stretch;
                gap: 6px;
                padding: 12px 0;
            }

            .reg-label {
                flex: none;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <body class="bg-[#F3F3F3]">
      <!-- Hearder Section -->
      <header class="w-full bg-[#008ECC] flex justify-center h-23 sm:h-23 md:h-23 lg:h-16 fixed top-0 z-50">
          <div class="w-screen  max-w-[1120px]">
               <div class="flex mt-2 sm:mt-2 md:mt-2 lg:mt-4">
                    <div class="menu-bar float-left cursor-pointer text-white ml-3 m-0 mr-4 h-8 w-8 openNav">
                         <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                              stroke="currentColor" class="h-8 w-8">
                              <path stroke-linecap="round" stroke-linejoin="round"
                                   d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
                         </svg>
                    </div>
                    <!-- Side Menu Section -->
                    
                    <!-- Logo  -->
                    <div class="logo flex justify-center mr-10">
                         <a href="Home.aspx" class="max-w-full text-white font-bold text-[22px]">
                               FlipShop
                         </a>
                    </div>
                    <!-- Search -->
                    <div
                         class="search-container w-[55%] h-9 mr-10 rounded bg-white hidden md:hidden sm:hidden lg:block">
                         <div class="search-box h-10 flex">
                              </header>
                                   <input type="text"
                                        class="w-full p-0 border-none border-transparent focus:border-transparent focus:ring-0"
                                        placeholder="Search essentials, groceries, and more …">
                              <div class="search-list w-6 h-6 mt-1.5"></div>
                         </div>
                    </div>
                    <!-- Login -->
                    <div class="login mt-1 mr-2 sm:mr-3 md:mr-3 lg:mr-8">
                         <a href="Login.aspx" class="text-sm text-white flex">
                              <span><svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" viewBox="0 0 20 20"
                                        fill="currentColor">
                                        <path fill-rule="evenodd"
                                             d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z"
                                             clip-rule="evenodd" />
                                   </svg></span>
                              <span class="hidden md:hidden sm:hidden lg:block  ml-2 mt-[2px]">Sign in / Sign up</span>
                         </a>
                    </div>
                    <!-- Cart -->
                    <div class="cart mt-[5px]">
                         <a href="cart.aspx" class="text-sm pl-2 text-white flex">
                              <span class="mr-3 sm:mr-3 md:mr-5 lg:mr-3">
                                   <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" viewBox="0 0 20 20"
                                        fill="currentColor">
                                        <path
                                             d="M3 1a1 1 0 000 2h1.22l.305 1.222a.997.997 0 00.01.042l1.358 5.43-.893.892C3.74 11.846 4.632 14 6.414 14H15a1 1 0 000-2H6.414l1-1H14a1 1 0 00.894-.553l3-6A1 1 0 0017 3H6.28l-.31-1.243A1 1 0 005 1H3zM16 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM6.5 18a1.5 1.5 0 100-3 1.5 1.5 0 000 3z" />
                                   </svg>
                              </span>
                              <span class="hidden md:hidden sm:hidden lg:block  mt-[1px]">Cart</span>
                         </a>
                    </div>
               </div>
               <!-- Mobile Search Section -->
               <div
                    class="mobile-search-container w-[95%] m-auto h-8 mt-1 rounded bg-white block md:block sm:block lg:hidden">
                    <div class="search-box h-10 flex">
                              <input type="text"
                                   class="w-full border-transparent focus:border-transparent focus:ring-0 border-none p-0"
                                   placeholder="Search essentials, groceries, and more …">
                         <div class="search-list mr-2 w-6 h-6 mt-1.5"></div>
                    </div>
               </div>
          </div>
     </header>
     <!-- Menu Section -->
     <div class="w-full bg-[#0c5273ef] fixed top-[64px] z-10 hidden sm:hidden md:hidden lg:block">
          <nav class="max-w-[1100px] m-auto">
               <ul class="flex">
                   <li class="relative parent-menu">
                    <a href="Filter.aspx" class="text-white font-semibold text-[14px] pr-4 py-2 block">Groceries</a>
                    <div class="child-menu">
                         <div class="absolute top-[37px]">
                              <ul class="max-w-[250px] min-w-[250px] bg-[#fff] p-[8px] shadow rounded-b-[6px]">
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Fruits</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Dairy</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Bakery</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Personal Care</a></li>
                              </ul>
                         </div>
                    </div>
                  </li>
                  <li class="relative parent-menu">
                    <a href="Filter.aspx" class="text-white font-semibold text-[14px] px-4 py-2 block">Home & Kitchen</a>
                    <div class="child-menu">
                         <div class="absolute top-[37px]">
                              <ul class="max-w-[250px] min-w-[250px] bg-[#fff] p-[8px] shadow rounded-b-[6px]">
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Kitchenware</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Furniture</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Tableware</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Home Decor</a></li>
                              </ul>
                         </div>
                    </div>
                   </li>
                   <li class="relative parent-menu">
                    <a href="Filter.aspx?categoryid=2" class="text-white font-semibold text-[14px] px-4 py-2 block">Fashion</a>
                    <div class="child-menu">
                         <div class="absolute top-[37px]">
                              <ul class="max-w-[250px] min-w-[250px] bg-[#fff] p-[8px] shadow rounded-b-[6px]">
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Men</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Women</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Boy</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Girl</a></li>
                              </ul>
                         </div>
                    </div>
                    </li>
                    <li class="relative parent-menu">
                    <a href="Filter.aspx" class="text-white font-semibold text-[14px] px-4 py-2 block">Electronics</a>
                    <div class="child-menu">
                         <div class="absolute top-[37px]">
                              <ul class="max-w-[250px] min-w-[250px] bg-[#fff] p-[8px] shadow rounded-b-[6px]">
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Mobiles</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Tablets</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Laptop</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Desktop</a></li>
                              </ul>
                         </div>
                    </div>
                    </li>
                    <li class="relative parent-menu">
                    <a href="Filter.aspx" class="text-white font-semibold text-[14px] px-4 py-2 block">Beauty</a>
                    <div class="child-menu">
                         <div class="absolute top-[37px]">
                              <ul class="max-w-[250px] min-w-[250px] bg-[#fff] p-[8px] shadow rounded-b-[6px]">
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Make-Up</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Hair</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Skin Care</a></li>
                                   <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Fragrances</a></li>
                              </ul>
                         </div>
                    </div>
                    </li>
                    <li class="relative parent-menu">
                         <a href="#" class="text-white font-semibold text-[14px] px-4 py-2 block">Pages</a>
                         <div class="child-menu">
                              <div class="absolute top-[37px]">
                                   <ul class="max-w-[250px] min-w-[250px] bg-[#fff] p-[8px] shadow rounded-b-[6px]">
                                        <li><a href="Login.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Login/Signup Page</a></li>
                                        <li><a href="verify.html" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">OTP Verify Page</a></li>
                                        <li><a href="Filter.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Shop Page</a></li>
                                        <li><a href="ProductDetails.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Shop Single Page</a></li>
                                        <li><a href="cart.aspx" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Cart Page</a></li>
                                        <li><a href="checkout.html" class="py-2 px-1 block rounded hover:bg-gray-100 hover:text-black">Checkout Page</a></li>
                                   </ul>
                              </div>
                         </div>
                    </li>
               </ul>
         </nav>
     </div>
     <!-- User Registration Section -->
     <div class="reg-page-wrap">
          <div class="reg-card">

               <div class="reg-card-header">
                    <h1>User Registration</h1>
                    <p>Register to continue shopping with FlipShop</p>
               </div>

               <div class="reg-row">
                    <label for="TextBox1" class="reg-label">Username</label>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="reg-input" placeholder="Choose a username"></asp:TextBox>
               </div>

               <div class="reg-row">
                    <label for="TextBox2" class="reg-label">Address</label>
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="reg-input" placeholder="Enter your address"></asp:TextBox>
               </div>

               <div class="reg-row">
                    <label for="TextBox3" class="reg-label">Phone no</label>
                    <asp:TextBox ID="TextBox3" runat="server" CssClass="reg-input" placeholder="Enter your phone number"></asp:TextBox>
               </div>

               <div class="reg-row">
                    <label for="TextBox4" class="reg-label">Email</label>
                    <asp:TextBox ID="TextBox4" runat="server" CssClass="reg-input" TextMode="Email" placeholder="Enter your email"></asp:TextBox>
               </div>

               <div class="reg-row">
                    <label for="TextBox5" class="reg-label">Password</label>
                    <asp:TextBox ID="TextBox5" runat="server" CssClass="reg-input" TextMode="Password" placeholder="Create a password"></asp:TextBox>
               </div>

               <div class="reg-row">
                    <label for="TextBox6" class="reg-label">Confirm Password</label>
                    <asp:TextBox ID="TextBox6" runat="server" CssClass="reg-input" TextMode="Password" placeholder="Re-enter your password"></asp:TextBox>
               </div>

               <div class="reg-actions">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" CssClass="reg-submit-btn" />
               </div>

               <asp:Label ID="Label1" runat="server" Text="Label" Visible="False" CssClass="reg-status"></asp:Label>

          </div>
     </div>

        </form>

     <!-- Footer -->
     <footer class="bg-gray-200 mt-28">
          <div class="footer max-w-[1120px] m-auto p-8">
               <div class="grid grid-cols-2 sm:grid-cols-2 md:grid-cols-2 lg:grid-cols-4">
                    <div>
                         <p class="text-black font-bold text-[15px]">All Categories</p>
                         <ul class="mt-3 text-xs text-gray-600">
                              <li><a href="#" class="py-2 text-[14px] block hover:bg-gray-300 hover:pl-1">Grocery</a></li>
                              <li><a href="#" class="py-2 text-[14px] block hover:bg-gray-300 hover:pl-1">Electronics</a></li>
                              <li><a href="#" class="py-2 text-[14px] block hover:bg-gray-300 hover:pl-1">Fashion</a></li>
                              <li><a href="#" class="py-2 text-[14px] block hover:bg-gray-300 hover:pl-1">Beauty</a></li>
                         </ul>
                    </div>
                    <div>
                         <p class="text-black font-bold text-[15px]">Popular Categories</p>
                         <ul class="mt-3 text-xs text-gray-600">
                              <li><a href="#" class="py-2 text-[14px] block hover:bg-gray-300 hover:pl-1">Staples</a></li>
                              <li><a href="#" class="py-2 text-[14px] block hover:bg-gray-300 hover:pl-1">Beverages</a></li>
                              <li><a href="#" class="py-2 text-[14px] block hover:bg-gray-300 hover:pl-1">Dairy & Bakery</a></li>
                              <li><a href="#" class="py-2 text-[14px] block hover:bg-gray-300 hover:pl-1">Snacks & Branded Foods</a></li>
                         </ul>
                    </div>
                    <div>
                         <p class="text-black font-bold text-[15px] mt-3 sm:mt-3 md:mt-3 lg:mt-0">Customer Account</p>
                         <ul class="mt-3 text-xs text-gray-600">
                              <li><a href="#" class="py-2 text-[14px] block hover:bg-gray-300 hover:pl-1">My Account</a></li>
                              <li><a href="#" class="py-2 text-[14px] block hover:bg-gray-300 hover:pl-1">My Orders</a></li>
                              <li><a href="#" class="py-2 text-[14px] block hover:bg-gray-300 hover:pl-1">Wishlist</a></li>
                              <li><a href="#" class="py-2 text-[14px] block hover:bg-gray-300 hover:pl-1">Payment Methods</a></li>
                         </ul>
                    </div>
                    <div>
                         <p class="text-black font-bold text-[15px] mt-3 sm:mt-3 md:mt-3 lg:mt-0">Contact Us</p>
                         <div class="footer_contact mt-3">
                              <div class="flex text-[14px] text-gray-600">
                                   <span class="icn">
                                        <?xml version="1.0" encoding="utf-8"?>
                                        <svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M12 21C15.5 17.4 19 14.1764 19 10.2C19 6.22355 15.866 3 12 3C8.13401 3 5 6.22355 5 10.2C5 14.1764 8.5 17.4 12 21Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        <path d="M12 12C13.1046 12 14 11.1046 14 10C14 8.89543 13.1046 8 12 8C10.8954 8 10 8.89543 10 10C10 11.1046 10.8954 12 12 12Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                        </svg>
                                   </span>
                                  <div class="ml-2">
                                   <p>Widgetify Inc. <br>Gadget Avenue Techtown <br>United States of America</p>
                                  </div>
                              </div>
                              <div class="flex text-[14px] text-gray-600 py-2">
                                   <span class="icn">
                                        <?xml version="1.0" encoding="utf-8"?>
                                        <svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M17.3545 22.2323C15.3344 21.7262 11.1989 20.2993 7.44976 16.5502C3.70065 12.8011 2.2738 8.66559 1.76767 6.6455C1.47681 5.48459 2.00058 4.36434 2.88869 3.72997L5.21694 2.06693C6.57922 1.09388 8.47432 1.42407 9.42724 2.80051L10.893 4.91776C11.5152 5.8165 11.3006 7.0483 10.4111 7.68365L9.24234 8.51849C9.41923 9.1951 9.96939 10.5846 11.6924 12.3076C13.4154 14.0306 14.8049 14.5807 15.4815 14.7576L16.3163 13.5888C16.9517 12.6994 18.1835 12.4847 19.0822 13.1069L21.1995 14.5727C22.5759 15.5257 22.9061 17.4207 21.933 18.783L20.27 21.1113C19.6356 21.9994 18.5154 22.5232 17.3545 22.2323ZM8.86397 15.136C12.2734 18.5454 16.0358 19.8401 17.8405 20.2923C18.1043 20.3583 18.4232 20.2558 18.6425 19.9488L20.3056 17.6205C20.6299 17.1665 20.5199 16.5348 20.061 16.2171L17.9438 14.7513L17.0479 16.0056C16.6818 16.5182 16.0047 16.9202 15.2163 16.7501C14.2323 16.5378 12.4133 15.8569 10.2782 13.7218C8.1431 11.5867 7.46219 9.7677 7.24987 8.7837C7.07977 7.9953 7.48181 7.31821 7.99439 6.95208L9.24864 6.05618L7.78285 3.93893C7.46521 3.48011 6.83351 3.37005 6.37942 3.6944L4.05117 5.35744C3.74413 5.57675 3.64162 5.89565 3.70771 6.15943C4.15989 7.96418 5.45459 11.7266 8.86397 15.136Z" fill="#0F0F0F"/>
                                        </svg>
                                   </span>
                                  <div class="ml-2">
                                   <p>(987) 654-3210, (555) 123-4567</p>
                                  </div>
                              </div>
                              <div class="flex text-[14px] text-gray-600 py-2">
                                   <span class="icn">
                                   <?xml version="1.0" encoding="utf-8"?>
                                   <svg width="20px" height="20px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                   <path d="M4 7.00005L10.2 11.65C11.2667 12.45 12.7333 12.45 13.8 11.65L20 7" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                   <rect x="3" y="5" width="18" height="14" rx="2" stroke="#000000" stroke-width="2" stroke-linecap="round"/>
                                   </svg>
                                   </span>
                                  <div class="ml-2">
                                   <p>info@example.com</p>
                                  </div>
                              </div>
                          </div>
                    </div>
               </div>
          </div>
          <div class="copy-right text-center pb-3 pt-3 border-t border-gray-300">
               <p class="text-[13px]">© 2022 All rights reserved.</p>
          </div>
     </footer>
     <script src="./assets/js/jquery-3.6.0.min.js"></script>
     <script src="./assets/js/main.js"></script>

        <div>
        </div>
    </form>
</body>
</html>

