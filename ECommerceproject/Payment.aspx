<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="ECommerceproject.Payment" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- Bootstrap powers the payment layout; existing FlipShop styles keep the storefront header intact. -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap-grid.min.css" rel="stylesheet" crossorigin="anonymous" />
    <link href="./assets/css/output.css" rel="stylesheet" />
    <link href="./assets/css/custom.css" rel="stylesheet" />
    <title>Secure Online Payment | FlipShop</title>
    <style type="text/css">
        :root { --pay-ink:#122638; --pay-muted:#597183; --pay-blue:#008ECC; --pay-deep:#075b82; --pay-line:#dce7ed; --pay-bg:#f4f9fb; --pay-green:#197b55; --pay-red:#b34040; }
        html,body { margin:0; background:var(--pay-bg); }
        /* Floating orbs sit behind the page content; panels stay above them. */
        .pay-page { min-height:720px; padding:126px 18px 72px; background:transparent; color:var(--pay-ink); font-family:Arial,Helvetica,sans-serif; position:relative; z-index:1; }
        .pay-orbs { position:fixed; inset:0; z-index:0; overflow:hidden; pointer-events:none; }
        .pay-orbs .orb { position:absolute; border-radius:50%; filter:blur(64px); will-change:transform; }
        .orb-1 { width:540px; height:540px; left:-150px; top:12%; background:radial-gradient(circle at 32% 32%, rgba(0,142,204,.42), rgba(0,142,204,0) 68%); animation:pay-drift-1 26s ease-in-out infinite alternate; }
        .orb-2 { width:640px; height:640px; right:-190px; top:28%; background:radial-gradient(circle at 60% 40%, rgba(7,91,130,.30), rgba(7,91,130,0) 68%); animation:pay-drift-2 34s ease-in-out infinite alternate; }
        .orb-3 { width:460px; height:460px; left:30%; bottom:-180px; background:radial-gradient(circle at 50% 50%, rgba(23,178,196,.26), rgba(23,178,196,0) 70%); animation:pay-drift-3 40s ease-in-out infinite alternate; }
        .orb-4 { width:380px; height:380px; left:58%; top:-120px; background:radial-gradient(circle at 40% 60%, rgba(0,142,204,.20), rgba(0,142,204,0) 70%); animation:pay-drift-1 30s ease-in-out infinite alternate-reverse; }
        @keyframes pay-drift-1 { from { transform:translate3d(0,0,0) scale(1); } to { transform:translate3d(70px,50px,0) scale(1.12); } }
        @keyframes pay-drift-2 { from { transform:translate3d(0,0,0) scale(1.06); } to { transform:translate3d(-80px,-60px,0) scale(.94); } }
        @keyframes pay-drift-3 { from { transform:translate3d(0,0,0) scale(.96); } to { transform:translate3d(60px,-55px,0) scale(1.1); } }
        footer.bg-gray-200 { position:relative; z-index:1; }
        .pay-wrap { max-width:1090px; margin:auto; }
        .pay-back { display:inline-flex; align-items:center; gap:7px; margin-bottom:22px; color:var(--pay-deep); text-decoration:none; font-size:13px; font-weight:700; }
        .pay-back:hover { text-decoration:underline; }
        .pay-intro { margin-bottom:26px; }
        .pay-step { display:flex; align-items:center; gap:10px; margin:0 0 12px; color:var(--pay-deep); font-size:11px; font-weight:800; text-transform:uppercase; letter-spacing:.1em; }
        .pay-step i { width:22px; height:22px; display:grid; place-items:center; border-radius:50%; font-style:normal; background:#d9f2fb; }
        .pay-intro h1 { margin:0; font-size:clamp(28px,4vw,40px); line-height:1.14; letter-spacing:-.025em; font-weight:800; }
        .pay-intro p { margin:9px 0 0; font-size:14px; color:var(--pay-muted); }
        .pay-layout { align-items:start; }
        .pay-layout > div { min-width:0; }
        .pay-layout .pay-panel { height:auto; }
        .pay-panel { background:#fff; border:1px solid var(--pay-line); border-radius:8px; box-shadow:0 14px 36px rgba(15,57,78,.055); }
        .pay-methods { padding:32px; }
        .pay-choose { display:inline-block; border-radius:100px; background:#e8f5fb; color:var(--pay-deep) !important; font-size:11px !important; font-weight:700; padding:7px 10px; }
        .pay-section-head { display:flex; justify-content:space-between; align-items:center; gap:12px; margin-bottom:18px; }
        .pay-section-head h2 { margin:0; font-size:20px; line-height:1.3; font-weight:800; }
        .pay-section-head span { font-size:12px; color:var(--pay-muted); }
        .pay-options { display:grid; gap:10px; }
        .pay-option { position:relative; display:flex; align-items:center; gap:14px; min-height:72px; padding:15px 16px; border:1px solid var(--pay-line); border-radius:6px; background:#fff; cursor:pointer; transition:border-color .18s,background-color .18s,box-shadow .18s; }
        .pay-option:hover,.pay-option:focus-within { border-color:var(--pay-blue); }
        .pay-option:has(input:checked) { border-color:var(--pay-blue); background:#f0faff; box-shadow:inset 0 0 0 1px var(--pay-blue),0 4px 14px rgba(0,142,204,.08); }
        .pay-option input { width:17px; height:17px; flex:none; accent-color:var(--pay-blue); }
        .pay-option-icon { width:38px; height:38px; flex:none; display:grid; place-items:center; border-radius:6px; color:var(--pay-deep); background:#e7f5fa; }
        .pay-option-icon svg { width:21px; height:21px; }
        .pay-option-copy { display:grid; gap:3px; min-width:0; }
        .pay-option-copy strong { font-size:14px; }
        .pay-option-copy small { font-size:12px; color:var(--pay-muted); }
        .pay-detail { margin-top:18px; border:1px solid var(--pay-line); border-radius:6px; padding:20px; background:#f8fbfc; }
        .pay-detail[hidden],.pay-result[hidden],.pay-status[hidden] { display:none !important; }
        .pay-detail-head { display:flex; align-items:center; gap:10px; font-size:14px; font-weight:800; margin:0 0 18px; }
        .pay-detail-head svg { width:20px; height:20px; color:var(--pay-blue); }
        .pay-balance { position:relative; overflow:hidden; padding:24px; color:#fff; background:#123f55; border-radius:6px; margin-bottom:14px; min-height:126px; }
        .pay-balance-icon { position:absolute; right:22px; top:21px; width:30px; height:30px; color:#bce1e8; opacity:.85; }
        .pay-balance-icon svg { width:100%; height:100%; }
        .pay-balance-sub { display:block; margin-top:17px; color:#bce1e8; font-size:11px; }
        .pay-balance small { color:#bce1e8; font-size:12px; }
        .pay-balance strong { display:block; margin-top:5px; font-size:26px; font-weight:800; font-variant-numeric:tabular-nums; }
        .pay-row { display:flex; justify-content:space-between; gap:12px; align-items:start; padding:11px 0; font-size:13px; border-bottom:1px solid var(--pay-line); }
        .pay-row:last-child { border-bottom:0; }
        .pay-row span { color:var(--pay-muted); }
        .pay-row strong { text-align:right; font-size:14px; overflow-wrap:anywhere; font-variant-numeric:tabular-nums; }
        .pay-row.emphasis strong { color:var(--pay-green); }
        .pay-note { color:var(--pay-muted); font-size:12px; line-height:1.6; margin:12px 0 0; }
        .pay-summary { position:sticky; top:119px; padding:28px; }
        .pay-summary-top { display:flex; align-items:center; gap:11px; padding-bottom:18px; border-bottom:1px solid var(--pay-line); margin-bottom:8px; }
        .pay-summary-mark { display:grid; place-items:center; width:38px; height:38px; border-radius:6px; color:var(--pay-deep); background:#e8f5fb; flex:none; }
        .pay-summary-mark svg { width:21px; height:21px; }
        .pay-summary h2 { margin:0; font-size:19px; font-weight:800; }
        .pay-summary .pay-row { padding:13px 0; }
        .pay-due { border-top:1px solid var(--pay-line); margin-top:6px; padding:20px 0 4px; display:flex; justify-content:space-between; gap:14px; align-items:end; }
        .pay-due span { font-size:13px; font-weight:700; }
        .pay-due strong { font-size:25px; font-weight:800; white-space:nowrap; font-variant-numeric:tabular-nums; }
        .pay-action { display:block; width:100%; min-height:52px; margin-top:24px; padding:12px 18px; border:0; border-radius:6px; background:var(--pay-blue); color:#fff; font:700 15px Arial,Helvetica,sans-serif; text-align:center; cursor:pointer; transition:background-color .18s,transform .18s; }
        .pay-action:hover:not(:disabled) { transform:translateY(-1px); }
        .pay-action:hover:not(:disabled) { background:var(--pay-deep); }
        .pay-action:disabled { background:#9aadb7; cursor:not-allowed; opacity:1; }
        .pay-secure { display:flex; justify-content:center; align-items:center; gap:7px; margin:16px 0 0; font-size:12px; color:var(--pay-muted); }
        .pay-secure svg { width:15px; height:15px; flex:none; color:var(--pay-green); }
        .pay-status { margin:0 0 18px; padding:13px 15px; border:1px solid #cbdfe9; border-radius:6px; background:#ecf7fb; color:#20566e; font-size:13px; line-height:1.5; }
        .pay-status.error { border-color:#f0c9c9; color:var(--pay-red); background:#fff3f3; }
        .pay-result { padding:24px 28px; margin-bottom:22px; border-left:4px solid var(--pay-blue); }
        .pay-result[data-state="success"] { border-color:var(--pay-green); }
        .pay-result[data-state="failed"],.pay-result[data-state="insufficient"] { border-color:var(--pay-red); }
        .pay-result h2 { margin:0 0 6px; font-size:20px; }
        .pay-result p { margin:0; font-size:13px; line-height:1.6; color:var(--pay-muted); }
        .pay-result dl { display:flex; flex-wrap:wrap; gap:20px; margin:17px 0 0; }
        .pay-result dt { font-size:11px; color:var(--pay-muted); }
        .pay-result dd { margin:4px 0 0; font-size:13px; font-weight:700; overflow-wrap:anywhere; }
        .pay-spinner { width:16px; height:16px; border:2px solid #bedce9; border-top-color:var(--pay-blue); border-radius:50%; display:inline-block; vertical-align:middle; margin-right:8px; animation:pay-spin .85s linear infinite; }
        @keyframes pay-spin { to { transform:rotate(360deg); } }
        @media (min-width:1024px) { .pay-page { padding-top:149px; } }
        @media (max-width:991px) { .pay-summary { position:static; } .pay-page { padding-bottom:42px; } }
        @media (max-width:480px) { .pay-orbs .orb { filter:blur(48px); } .orb-1 { width:340px; height:340px; } .orb-2 { width:400px; height:400px; } .orb-3 { width:300px; height:300px; } .orb-4 { width:260px; height:260px; } .pay-page { padding-left:14px; padding-right:14px; } .pay-methods,.pay-summary { padding:19px; } .pay-option { padding:13px 11px; gap:10px; } .pay-option-icon { width:34px; height:34px; } .pay-section-head { align-items:start; flex-direction:column; gap:4px; } }
        @media (prefers-reduced-motion:reduce) { .pay-orbs .orb { animation:none; } .pay-spinner { animation:none; } .pay-option,.pay-action { transition:none; } .pay-action:hover:not(:disabled) { transform:none; } }
    </style>
</head>
<body>
    <div class="pay-orbs" aria-hidden="true">
        <span class="orb orb-1"></span><span class="orb orb-2"></span><span class="orb orb-3"></span><span class="orb orb-4"></span>
    </div>
    <form id="form1" runat="server">
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
                <div class="mobile-search-container w-[95%] m-auto h-8 mt-1 rounded bg-white block md:block sm:block lg:hidden">
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

        <%-- Hidden fields remain only for legacy layout compatibility. Server code never trusts them. --%>
        <asp:HiddenField ID="OrderIdField" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="AmountField" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="BankBalanceField" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="PaymentOutcomeField" ClientIDMode="Static" runat="server" />
        <asp:HiddenField ID="TransactionIdField" ClientIDMode="Static" runat="server" />
        <main class="pay-page">
            <div class="pay-wrap container">
                <a class="pay-back" href="Checkout.aspx" aria-label="Back to checkout">← Back to checkout</a>
                <div class="pay-intro">
                    <p class="pay-step"><i>3</i> Checkout / Payment</p>
                    <h1>Complete your payment</h1>
                    <p>Review your order, choose a payment method, and confirm when you're ready.</p>
                </div>
                <section class="pay-result pay-panel" id="paymentResult" hidden aria-live="polite" role="status">
                    <h2 id="resultTitle"></h2><p id="resultDescription"></p>
                    <dl id="resultReference" hidden><div><dt>Order ID</dt><dd id="resultOrder"></dd></div><div id="resultTransactionBlock" hidden><dt>Transaction ID</dt><dd id="resultTransaction"></dd></div></dl>
                </section>
                <div class="row g-4 pay-layout">
                    <div class="col-12 col-lg-7">
                    <section class="pay-panel pay-methods" aria-labelledby="methodsHeading">
                        <div class="pay-section-head"><h2 id="methodsHeading">Select payment method</h2><span class="badge rounded-pill pay-choose">Choose one option</span></div>
                        <div class="pay-options" role="radiogroup" aria-label="Payment method">
                            <label class="pay-option"><input type="radio" name="paymentMethod" value="upi" /><span class="pay-option-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M3 8h18M7 3l-4 5 4 5M17 11l4 5-4 5M9 20l6-16" stroke-linecap="round" stroke-linejoin="round"/></svg></span><span class="pay-option-copy"><strong>UPI</strong><small>Pay through a UPI app</small></span></label>
                            <label class="pay-option"><input type="radio" name="paymentMethod" value="card" /><span class="pay-option-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="2" y="4" width="20" height="16" rx="2"/><path d="M2 10h20M6 16h5" stroke-linecap="round"/></svg></span><span class="pay-option-copy"><strong>Debit / Credit Card</strong><small>Pay with a card</small></span></label>
                            <label class="pay-option"><input type="radio" name="paymentMethod" value="demo-bank" checked="checked" /><span class="pay-option-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="m2 9 10-6 10 6M3 9h18M5 10v9m5-9v9m4-9v9m5-9v9M2 21h20" stroke-linecap="round" stroke-linejoin="round"/></svg></span><span class="pay-option-copy"><strong>Demo Bank</strong><small>Pay using your project bank balance</small></span></label>
                        </div>
                        <section class="pay-detail" id="demoBankDetail" aria-label="Demo Bank payment details">
                            <h3 class="pay-detail-head"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="m2 9 10-6 10 6M3 9h18M5 10v9m5-9v9m4-9v9m5-9v9M2 21h20" stroke-linecap="round" stroke-linejoin="round"/></svg> Your Demo Bank account</h3>
                            <div class="pay-balance"><span class="pay-balance-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7"><path d="M3 8h18v12H3zM3 8l9-5 9 5M7 13h10M7 16h6" stroke-linecap="round" stroke-linejoin="round"/></svg></span><small>Available balance</small><strong><asp:Literal ID="litBalance" runat="server" Text="Unavailable" /></strong><span class="pay-balance-sub">Demo Bank account</span></div>
                            <div class="pay-row"><span>Amount being charged</span><strong><asp:Literal ID="litCharge" runat="server" Text="&mdash;" /></strong></div>
                            <div class="pay-row emphasis"><span>Projected balance after payment</span><strong><asp:Literal ID="litRemaining" runat="server" Text="&mdash;" /></strong></div>
                            <p class="pay-note">Projected balance is an estimate. Your balance changes only after your project processes the payment.</p>
                        </section>
                        <section class="pay-detail" id="otherMethodDetail" hidden aria-live="polite"><h3 class="pay-detail-head" id="otherMethodTitle">Payment method</h3><p class="pay-note">This payment method is not connected yet. No payment will be processed here.</p></section>
                    </section>
                    </div>
                    <div class="col-12 col-lg-5">
                    <aside class="pay-panel pay-summary" aria-labelledby="summaryHeading">
                        <div class="pay-summary-top"><span class="pay-summary-mark" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M8 3h9a2 2 0 012 2v16l-3.5-2-3.5 2-3.5-2L5 21V6a3 3 0 013-3zM9 9h6M9 13h6" stroke-linecap="round" stroke-linejoin="round"/></svg></span><h2 id="summaryHeading">Order summary</h2></div>
                        <div class="pay-row"><span>Items</span><strong><asp:Literal ID="litItems" runat="server" Text="Unavailable" /></strong></div>
                        <asp:Repeater ID="rptPaymentItems" runat="server"><HeaderTemplate><ul class="pay-note"></HeaderTemplate><ItemTemplate><li><%#: Eval("ProductName") %> &times; <%#: Eval("Quantity") %></li></ItemTemplate><FooterTemplate></ul></FooterTemplate></asp:Repeater>
                        <div class="pay-due"><span>Total amount to pay</span><strong><asp:Literal ID="litTotal" runat="server" Text="&mdash;" /></strong></div>
                        <asp:Button ID="btnPayNow" runat="server" ClientIDMode="Static" CssClass="pay-action" Text="Pay Now" Enabled="false" UseSubmitBehavior="false" OnClick="btnPayNow_Click" />
                        <p class="pay-secure"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="4" y="10" width="16" height="11" rx="2"/><path d="M8 10V7a4 4 0 0 1 8 0v3"/></svg> Simulated payment · No real bank or gateway</p>
                        <p class="pay-status" id="dataStatus" role="status"><asp:Literal ID="litStatus" runat="server" Text="Waiting for order and account details." /></p>
                    </aside>
                    </div>
                </div>
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
                <p class="text-[13px]">© 2022 All rights reserved.</p>
            </div>
        </footer>

    </form>
    <script>
        (function () {
            var options = document.querySelectorAll('input[name="paymentMethod"]');
            var demo = document.getElementById('demoBankDetail');
            var other = document.getElementById('otherMethodDetail');
            var title = document.getElementById('otherMethodTitle');
            var status = document.getElementById('dataStatus');
            var pay = document.getElementById('btnPayNow');
            if (!demo || !other || !status || !pay) return;
            var serverAllowsPay = !pay.disabled;
            var serverMessage = status.textContent;
            function refresh() {
                var choice = document.querySelector('input[name="paymentMethod"]:checked');
                var value = choice ? choice.value : '';
                demo.hidden = value !== 'demo-bank';
                other.hidden = value === 'demo-bank';
                if (title && value !== 'demo-bank') title.textContent = value === 'upi' ? 'UPI payment' : 'Debit / Credit Card payment';
                if (value === 'demo-bank') {
                    status.textContent = serverMessage;
                    pay.disabled = !serverAllowsPay;
                } else {
                    status.textContent = 'This payment method is not connected. Choose Demo Bank to continue; no UPI or card payment will be processed.';
                    pay.disabled = true;
                }
            }
            Array.prototype.forEach.call(options, function (option) { option.addEventListener('change', refresh); });
            refresh();
        })();
    </script>
    <script src="./assets/js/jquery-3.6.0.min.js"></script>
    <script src="./assets/js/main.js"></script>
</body>
</html>


