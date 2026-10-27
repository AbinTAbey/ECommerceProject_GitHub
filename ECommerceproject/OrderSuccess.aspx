<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderSuccess.aspx.cs" Inherits="ECommerceproject.OrderSuccess" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Order confirmed | FlipShop</title>
<meta name="description" content="Your FlipShop order and simulated Demo Bank payment are confirmed." />
<meta property="og:title" content="Order confirmed | FlipShop" />
<meta property="og:description" content="Your FlipShop order and simulated Demo Bank payment are confirmed." />
<meta property="og:type" content="website" />
<meta name="twitter:card" content="summary_large_image" />
<link href="./assets/css/output.css" rel="stylesheet" />
<link href="./assets/css/custom.css" rel="stylesheet" />
<style type="text/css">
:root{--po-bg:#F8FAFC;--po-ink:#0F172A;--po-muted:#64748B;--po-green:#10B981;--po-white:#fff;--po-line:#E2E8F0;--po-blue:#008ECC;--po-blue-hover:#0070a3;--po-error:#DC2626;--po-gold-light:#FDE047;--po-gold-dark:#CA8A04;--po-shadow:0 12px 32px -24px #0F172A33;--po-ring:0 0 0 3px #008ECC22}
body{background:var(--po-bg);font-family:system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;margin:0}
.po-page,.po-page *{box-sizing:border-box;letter-spacing:0}.po-page{max-width:1100px;margin:auto;padding:136px 20px 24px;color:var(--po-ink)}
.po-crumb{font-size:13px;color:var(--po-muted);margin-bottom:24px}.po-crumb a{color:var(--po-blue)}
.po-workspace{max-width:760px;min-height:550px;margin:auto}.po-success{max-width:560px;margin:0 auto}.po-demo{text-align:center;font-size:12px;font-weight:600;color:var(--po-muted);margin:0 0 18px}
.po-form h1{font-size:30px;line-height:1.2;font-weight:700;margin:0 0 8px}.po-sub{font-size:15px;line-height:1.6;color:var(--po-muted);margin:0 0 30px}
.po-field{margin-bottom:20px}.po-field label{display:block;font-size:14px;font-weight:600;margin-bottom:8px}
.po-field input,.po-field textarea{display:block;width:100%;font:inherit;font-size:15px;color:var(--po-ink);background:var(--po-white);border:1px solid var(--po-line);border-radius:8px;padding:13px 14px;outline:none;transition:border-color .15s,box-shadow .15s}
.po-field textarea{height:112px;resize:vertical;min-height:90px;max-height:220px}.po-field input:focus,.po-field textarea:focus{border-color:var(--po-blue);box-shadow:var(--po-ring)}
.po-field [aria-invalid="true"]{border-color:var(--po-error)}.po-error{font-size:13px;color:var(--po-error);margin:6px 0 0}.po-field input::placeholder,.po-field textarea::placeholder{color:var(--po-muted)}
.po-action{display:inline-flex;align-items:center;justify-content:center;gap:10px;font:inherit;font-size:15px;font-weight:600;text-decoration:none;color:var(--po-white);background:var(--po-blue);border:0;border-radius:8px;padding:14px 22px;min-height:48px;cursor:pointer;box-shadow:var(--po-shadow);transition:background .15s}
.po-action:hover{background:var(--po-blue-hover)}.po-action:focus-visible{outline:3px solid var(--po-blue);outline-offset:4px}.po-form .po-action{width:100%}.po-action svg{width:18px;height:18px}
.po-disclaimer{font-size:12px;line-height:1.6;text-align:center;color:var(--po-muted);margin:16px 0 0}
.po-page [hidden]{display:none!important}.po-success{position:relative;height:550px;overflow:hidden;text-align:center;outline:none}.po-success:focus-visible{outline:2px solid var(--po-blue);outline-offset:4px;border-radius:8px}
.po-visual{position:absolute;top:228px;left:50%;width:100px;height:100px;transform:translate(-50%,-50%)}
.po-circle{height:100px;width:100px;border-radius:50%;background:var(--po-green);display:grid;place-items:center;transform:scale(0);position:relative;z-index:1}
.po-check{width:54px;height:54px;fill:none;stroke:var(--po-white);stroke-width:5;stroke-linecap:round;stroke-linejoin:round}.po-check path{stroke-dasharray:1;stroke-dashoffset:1}
.po-playing .po-circle{animation:po-spring .4s .2s both,po-fire .3s 1s forwards}.po-playing .po-check .po-short{animation:po-draw .2s .6s forwards}.po-playing .po-check .po-long{animation:po-draw .3s .8s forwards}
.po-coin{position:absolute;top:228px;left:50%;width:25px;height:25px;border:1px solid var(--po-gold-dark);border-radius:50%;background:radial-gradient(circle at 30% 25%,var(--po-gold-light),var(--po-gold-dark));opacity:0;pointer-events:none;z-index:2;display:grid;place-items:center;will-change:transform,opacity}
.po-coin span{display:grid;place-items:center;width:18px;height:18px;border:1px dashed var(--po-gold-dark);border-radius:50%;color:var(--po-gold-dark);font-size:12px;font-weight:800;line-height:1}
.po-copy{position:absolute;top:320px;left:0;width:100%;height:100px}.po-copy h2{font-size:28px;line-height:1.25;margin:0;font-weight:700}.po-payment{opacity:0}.po-order{position:absolute;inset:0;opacity:0;transform:translateY(18px)}
.po-reference{display:inline-block;background:var(--po-white);border:1px solid var(--po-line);border-radius:6px;padding:6px 12px;font-size:13px;font-weight:600;margin:16px 0 0;color:var(--po-muted)}
.po-playing .po-payment{animation:po-in .3s 1s both,po-out .3s 2.5s forwards}.po-playing .po-order{animation:po-in .4s 2.5s forwards}
.po-final-action{position:absolute;top:444px;left:0;width:100%}.po-complete .po-circle{animation:none;transform:scale(1)}.po-complete .po-check path{animation:none;stroke-dashoffset:0}.po-complete .po-payment{display:none}.po-complete .po-order{animation:none;opacity:1;transform:none}
@keyframes po-spring{0%{transform:scale(0)}55%{transform:scale(1.12)}80%{transform:scale(.96)}100%{transform:scale(1)}}
@keyframes po-fire{0%,100%{transform:scale(1) translateY(0)}40%{transform:scale(1.06) translateY(-6px)}70%{transform:scale(.98) translateY(2px)}}
@keyframes po-draw{to{stroke-dashoffset:0}}@keyframes po-in{from{opacity:0;transform:translateY(18px)}to{opacity:1;transform:translateY(0)}}@keyframes po-out{to{opacity:0;transform:translateY(-20px)}}
.po-sr{position:absolute;width:1px;height:1px;padding:0;margin:-1px;overflow:hidden;clip:rect(0,0,0,0);white-space:nowrap;border:0}
@media(max-width:1023px){.po-page{padding-top:126px}}@media(max-width:560px){.po-page{padding-inline:20px}.po-form h1{font-size:28px}.po-copy h2{font-size:24px}.po-crumb{margin-bottom:20px}}
@media(prefers-reduced-motion:reduce){.po-page *{animation:none!important;transition:none!important}.po-circle{transform:scale(1)}.po-check path{stroke-dashoffset:0}.po-payment,.po-coin{display:none}.po-order{opacity:1;transform:none}}
</style>
<style type="text/css">
.po-confirmation-card{width:100%;margin:0 auto 28px;padding:clamp(20px,4vw,32px);background:var(--po-white);border:1px solid var(--po-line);border-radius:14px;box-shadow:var(--po-shadow)}
.po-confirmation-head{display:flex;align-items:flex-start;justify-content:space-between;gap:20px;padding-bottom:22px;border-bottom:1px solid var(--po-line)}
.po-confirmation-eyebrow{margin:0 0 7px;color:var(--po-green);font-size:11px;font-weight:800;letter-spacing:.1em;text-transform:uppercase}
.po-confirmation-title{margin:0;font-size:clamp(22px,4vw,30px);line-height:1.2;font-weight:750}
.po-confirmation-subtitle{margin:7px 0 0;color:var(--po-muted);font-size:14px}
.po-paid{flex:none;text-align:right}.po-paid-label,.po-meta-label{display:block;color:var(--po-muted);font-size:12px;font-weight:600}
.po-paid-amount{display:block;margin-top:4px;color:var(--po-ink);font-size:clamp(24px,4vw,32px);line-height:1.15;font-weight:800;font-variant-numeric:tabular-nums;white-space:nowrap}
.po-confirmation-meta{display:flex;flex-wrap:wrap;align-items:center;gap:10px 26px;padding:17px 0;border-bottom:1px solid var(--po-line)}
.po-meta-value{display:block;margin-top:4px;color:var(--po-ink);font-size:14px;font-weight:700}.po-status-pill{display:inline-flex;align-items:center;gap:7px;padding:6px 10px;border-radius:100px;background:#ECFDF5;color:#047857;font-size:12px;font-weight:700}
.po-status-dot{width:7px;height:7px;border-radius:50%;background:#10B981}
.po-items-heading{margin:20px 0 9px;font-size:15px;font-weight:750}.po-items{list-style:none;margin:0;padding:0}
.po-item{display:grid;grid-template-columns:minmax(0,1fr) auto auto;align-items:center;gap:14px;padding:12px 0;border-bottom:1px solid #F1F5F9;font-size:14px}
.po-item-name{min-width:0;font-weight:650;overflow-wrap:anywhere}.po-item-quantity{color:var(--po-muted);font-size:13px;white-space:nowrap}.po-item-price{font-weight:700;font-variant-numeric:tabular-nums;white-space:nowrap}
.po-balance{display:flex;align-items:center;justify-content:space-between;gap:12px;margin-top:20px;padding:16px 18px;border:1px solid #BBF7D0;border-radius:10px;background:#F0FDF4}
.po-balance-label{color:#166534;font-size:13px;font-weight:650}.po-balance-value{color:#14532D;font-size:20px;font-weight:800;font-variant-numeric:tabular-nums;white-space:nowrap}
.po-transaction{display:flex;flex-wrap:wrap;align-items:center;gap:8px 12px;margin:17px 0 0;color:var(--po-muted);font-size:12px}
.po-transaction-id{font-weight:600;overflow-wrap:anywhere}.po-copy-button{border:1px solid var(--po-line);border-radius:6px;padding:5px 9px;background:#fff;color:var(--po-blue);font:inherit;font-weight:650;cursor:pointer}.po-copy-button:hover{background:#F8FAFC}.po-copy-status{min-height:1em;color:#047857}
@media(max-width:560px){.po-confirmation-head{flex-direction:column}.po-paid{text-align:left}.po-confirmation-meta{gap:14px 20px}.po-item{grid-template-columns:minmax(0,1fr) auto;gap:7px 12px}.po-item-quantity{grid-column:1;grid-row:2}.po-item-price{grid-column:2;grid-row:1 / span 2}}
</style>
</head>
<body>
<form id="form1" runat="server" novalidate>
        <!-- Header Section -->
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
                    <!-- Logo  -->
                    <div class="logo flex justify-center mr-10">
                        <a href="index.html" class="max-w-full text-white font-bold text-[22px]">
                            FlipShop
                        </a>
                    </div>
                    <!-- Search -->
                    <div class="search-container w-[55%] h-9 mr-10 rounded bg-white hidden md:hidden sm:hidden lg:block">
                        <div class="search-box h-10 flex">
                            <input type="text"
                                   class="w-full p-0 border-none border-transparent focus:border-transparent focus:ring-0"
                                   placeholder="Search essentials, groceries, and more &hellip;">
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
                <div class="mobile-search-container w-[95%] m-auto h-8 mt-1 rounded bg-white block md:block sm:block lg:hidden">
                    <div class="search-box h-10 flex">
                        <input type="text"
                               class="w-full border-transparent focus:border-transparent focus:ring-0 border-none p-0"
                               placeholder="Search essentials, groceries, and more &hellip;">
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

        <main class="po-page">
    <div class="po-crumb"><a href="Home.aspx">Home</a> / Order confirmation</div>
    <div class="po-workspace">
        <p class="po-demo">SIMULATED DEMO BANK PAYMENT · CONFIRMED</p>
        <section id="poSuccess" class="po-success po-playing" tabindex="-1" aria-label="Order confirmation">
            <div id="poCoins" aria-hidden="true"></div>
            <div class="po-visual" aria-hidden="true"><div class="po-circle"><svg class="po-check" viewBox="0 0 54 54"><path class="po-short" pathLength="1" d="M12 28 L22 38"/><path class="po-long" pathLength="1" d="M22 38 L42 17"/></svg></div></div>
            <div class="po-copy"><h2 class="po-payment">Payment Successful!</h2><div class="po-order"><h2>Order Successful!</h2><p class="po-reference">Order #<asp:Label ID="lblOrderId" runat="server" /></p></div></div>
            <div id="poFinalAction" class="po-final-action" hidden="hidden"><a href="Home.aspx" class="po-action">Continue shopping</a></div>
        </section>
        <p id="poAnnouncement" class="po-sr" role="status" aria-live="polite"></p>
        <section class="po-confirmation-card" aria-labelledby="confirmationHeading">
            <div class="po-confirmation-head">
                <div>
                    <p class="po-confirmation-eyebrow">Payment confirmed</p>
                    <h1 id="confirmationHeading" class="po-confirmation-title">Your order is confirmed</h1>
                    <p class="po-confirmation-subtitle">Thank you for shopping with FlipShop.</p>
                </div>
                <div class="po-paid"><span class="po-paid-label">Amount paid</span><strong class="po-paid-amount">&#8377;<asp:Label ID="lblPaymentAmount" runat="server" /></strong></div>
            </div>
            <div class="po-confirmation-meta">
                <div><span class="po-meta-label">Order ID</span><strong class="po-meta-value">#<asp:Label ID="lblConfirmationOrderId" runat="server" /></strong></div>
                <div><span class="po-meta-label">Status</span><span class="po-status-pill"><span class="po-status-dot" aria-hidden="true"></span><asp:Label ID="lblOrderStatus" runat="server" /></span></div>
                <div><span class="po-meta-label">Order and payment time</span><strong class="po-meta-value"><asp:Label ID="lblOrderDate" runat="server" /></strong></div>
            </div>
            <h2 class="po-items-heading">Order summary</h2>
            <asp:Repeater ID="rptItems" runat="server"><HeaderTemplate><ul class="po-items"></HeaderTemplate><ItemTemplate><li class="po-item"><span class="po-item-name"><%#: Eval("ProductName") %></span><span class="po-item-quantity">Qty <%#: Eval("Quantity") %></span><strong class="po-item-price">&#8377;<%#: GetItemPrice(Eval("Price")) %></strong></li></ItemTemplate><FooterTemplate></ul></FooterTemplate></asp:Repeater>
            <div class="po-balance"><span class="po-balance-label">Remaining Demo Bank balance</span><strong class="po-balance-value">&#8377;<asp:Label ID="lblFinalBalance" runat="server" /></strong></div>
            <div class="po-transaction"><span>Transaction ID</span><asp:Label ID="lblTransactionId" runat="server" ClientIDMode="Static" CssClass="po-transaction-id" /><button type="button" id="copyTransaction" class="po-copy-button">Copy</button><span id="copyTransactionStatus" class="po-copy-status" aria-live="polite"></span></div>
        </section>
    </div>
</main>
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
                            <li><a href="Payment.aspx" class="py-2 text-[14px] block hover:bg-gray-300 hover:pl-1">Online Payment</a></li>
                        </ul>
                    </div>
                    <div>
                        <p class="text-black font-bold text-[15px] mt-3 sm:mt-3 md:mt-3 lg:mt-0">Contact Us</p>
                        <div class="footer_contact mt-3">
                            <div class="flex text-[14px] text-gray-600">
                                <span class="icn">
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
                <p class="text-[13px]">&copy; 2022 All rights reserved.</p>
            </div>
        </footer>
</form>
<script>
(function () {
    'use strict';
    var stage = document.getElementById('poSuccess');
    var action = document.getElementById('poFinalAction');
    var layer = document.getElementById('poCoins');
    var coins = [];
    var frameHandle = 0;
    var start = 0;
    var lastFrame = -1;
    var motion = window.matchMedia('(prefers-reduced-motion: reduce)');
    if (!stage || !action || !layer) return;
    function finish() {
        if (frameHandle) cancelAnimationFrame(frameHandle);
        stage.classList.remove('po-playing');
        stage.classList.add('po-complete');
        stage.dataset.frame = '120';
        coins.forEach(function (coin) { coin.element.style.opacity = '0'; });
        action.hidden = false;
        var order = document.getElementById('lblOrderId');
        var announcement = document.getElementById('poAnnouncement');
        if (announcement) announcement.textContent = 'Payment confirmed for order ' + (order ? order.textContent : '') + '.';
    }
    function tick(now) {
        var frame = Math.min(120, Math.floor((now - start) * 30 / 1000));
        if (frame !== lastFrame) {
            lastFrame = frame;
            stage.dataset.frame = String(frame);
            if (frame >= 75) {
                var paymentTitle = stage.querySelector('.po-payment');
                if (paymentTitle) paymentTitle.setAttribute('aria-hidden', 'true');
            }
            var seconds = (frame - 30) / 30;
            var spread = Math.min(1, Math.max(0, (stage.clientWidth - 38) / 520));
            coins.forEach(function (coin) {
                var t = seconds - coin.delay;
                if (t < 0 || t >= 1.5) { coin.element.style.opacity = '0'; return; }
                var x = coin.vx * t * spread;
                var y = -coin.vy * t + 270 * t * t;
                coin.element.style.transform = 'translate(calc(-50% + ' + x + 'px),calc(-50% + ' + y + 'px)) rotate(' + ((coin.index % 2 ? -1 : 1) * (t * 420 + coin.index * 19)) + 'deg) rotateY(' + (t * (500 + coin.index * 9)) + 'deg)';
                coin.element.style.opacity = String(Math.min(1, t * 15) * Math.min(1, (1.5 - t) / .45));
            });
        }
        if (frame >= 120) { finish(); return; }
        frameHandle = requestAnimationFrame(tick);
    }
    function play() {
        if (motion.matches) { finish(); return; }
        for (var i = 0; i < 24; i++) {
            var element = document.createElement('div');
            element.className = 'po-coin';
            var ring = document.createElement('span');
            ring.textContent = '$';
            element.appendChild(ring);
            layer.appendChild(element);
            coins.push({ element: element, index: i, vx: (i - 11.5) * 18, vy: 260 + (i % 7) * 14, delay: (i % 4) / 30 });
        }
        start = performance.now();
        frameHandle = requestAnimationFrame(tick);
    }
    if (motion.matches) finish(); else play();
    window.addEventListener('pagehide', function () { if (frameHandle) cancelAnimationFrame(frameHandle); });
})();
</script>
<script>
(function () {
    var button = document.getElementById('copyTransaction');
    var transaction = document.getElementById('lblTransactionId');
    var status = document.getElementById('copyTransactionStatus');
    if (!button || !transaction || !status) return;

    function reportCopied(copied) {
        status.textContent = copied ? 'Copied' : 'Could not copy';
    }

    button.addEventListener('click', function () {
        var value = transaction.textContent.trim();
        if (!value) return;
        if (navigator.clipboard && window.isSecureContext) {
            navigator.clipboard.writeText(value).then(function () { reportCopied(true); }, function () { reportCopied(false); });
            return;
        }

        var field = document.createElement('textarea');
        field.value = value;
        field.setAttribute('readonly', 'readonly');
        field.style.position = 'fixed';
        field.style.opacity = '0';
        document.body.appendChild(field);
        field.select();
        var copied = false;
        try { copied = document.execCommand('copy'); } catch (error) { copied = false; }
        document.body.removeChild(field);
        reportCopied(copied);
    });
})();
</script>
<script src="./assets/js/jquery-3.6.0.min.js"></script>
<script src="./assets/js/main.js"></script>
</body>
</html>
