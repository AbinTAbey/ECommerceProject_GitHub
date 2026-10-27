<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ECommerceproject.Login" %>

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
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;family=Manrope:wght@600;700;800&amp;display=swap" rel="stylesheet">
    <style type="text/css">
        :root {
            --fs-primary: #087eae;
            --fs-primary-deep: #075d84;
            --fs-primary-soft: #eaf7fc;
            --fs-ink: #102a3a;
            --fs-muted: #667987;
            --fs-line: #dce8ee;
            --fs-surface: #ffffff;
            --fs-danger: #b42318;
            --fs-danger-bg: #fff2f0;
        }

        * { box-sizing: border-box; }

        html { scroll-behavior: smooth; }

        body {
            margin: 0;
            min-width: 320px;
            color: var(--fs-ink);
            background: #f4f9fb;
            font-family: "Inter", Arial, sans-serif;
            -webkit-font-smoothing: antialiased;
        }

        button, input { font: inherit; }

        .brand-font { font-family: "Manrope", Arial, sans-serif; }

        .auth-main {
            position: relative;
            isolation: isolate;
            min-height: 720px;
            padding: 150px 20px 72px;
            overflow: hidden;
            background:
                radial-gradient(circle at 12% 22%, rgba(8, 142, 204, .08), transparent 28%),
                linear-gradient(180deg, #f8fcfd 0%, #eef7fa 100%);
        }

        .auth-main::before {
            content: "";
            position: absolute;
            z-index: -1;
            inset: 102px 0 auto;
            height: 1px;
            background: rgba(8, 126, 174, .08);
        }

        .auth-layout {
            width: 100%;
            max-width: 1080px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: minmax(0, .9fr) minmax(390px, 480px);
            align-items: center;
            gap: clamp(52px, 8vw, 108px);
        }

        .auth-intro { max-width: 470px; }

        .auth-eyebrow {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            margin-bottom: 22px;
            color: var(--fs-primary-deep);
            font-size: 12px;
            font-weight: 700;
            letter-spacing: .12em;
            text-transform: uppercase;
        }

        .auth-eyebrow::before {
            content: "";
            width: 28px;
            height: 2px;
            border-radius: 999px;
            background: var(--fs-primary);
        }

        .auth-title {
            margin: 0;
            color: #0c2637;
            font-family: "Manrope", Arial, sans-serif;
            font-size: clamp(38px, 5vw, 58px);
            font-weight: 800;
            line-height: 1.08;
            letter-spacing: -.035em;
        }

        .auth-copy {
            max-width: 430px;
            margin: 22px 0 30px;
            color: var(--fs-muted);
            font-size: 16px;
            line-height: 1.75;
        }

        .trust-list {
            display: grid;
            gap: 14px;
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .trust-list li {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #3f5968;
            font-size: 14px;
            font-weight: 600;
        }

        .trust-icon {
            display: grid;
            width: 30px;
            height: 30px;
            flex: 0 0 30px;
            place-items: center;
            color: var(--fs-primary);
            border: 1px solid #cce6f0;
            border-radius: 50%;
            background: rgba(255, 255, 255, .8);
        }

        .auth-card {
            position: relative;
            width: 100%;
            overflow: hidden;
            border: 1px solid rgba(203, 220, 228, .9);
            border-radius: 22px;
            background: rgba(255, 255, 255, .94);
            box-shadow: 0 24px 70px rgba(27, 73, 94, .13), 0 2px 8px rgba(27, 73, 94, .05);
        }

        .auth-card::before {
            content: "";
            display: block;
            height: 4px;
            background: var(--fs-primary);
        }

        .auth-card-inner { padding: 34px 38px 36px; }

        .auth-card-heading { margin-bottom: 25px; }

        .auth-card-heading h2 {
            margin: 0 0 7px;
            color: #112d3d;
            font-family: "Manrope", Arial, sans-serif;
            font-size: 25px;
            font-weight: 800;
            letter-spacing: -.02em;
        }

        .auth-card-heading p {
            margin: 0;
            color: var(--fs-muted);
            font-size: 13px;
            line-height: 1.55;
        }

        .login-mode-label {
            display: block;
            margin: 0 0 9px;
            color: #314b5b;
            font-size: 12px;
            font-weight: 700;
        }

        .login-mode {
            width: 100% !important;
            margin: 0 0 24px;
            border-collapse: separate;
            border-spacing: 4px;
            border: 1px solid var(--fs-line);
            border-radius: 12px;
            background: #edf4f7;
            table-layout: fixed;
        }

        .login-mode tbody, .login-mode tr { width: 100%; }

        .login-mode td {
            position: relative;
            width: 50%;
            padding: 0;
            text-align: center;
        }

        .login-mode input {
            position: absolute;
            width: 1px;
            height: 1px;
            opacity: 0;
        }

        .login-mode label {
            display: block;
            padding: 10px 14px;
            cursor: pointer;
            color: #637784;
            border: 1px solid transparent;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 700;
            transition: color .2s ease, background-color .2s ease, box-shadow .2s ease;
        }

        .login-mode input:checked + label {
            color: var(--fs-primary-deep);
            border-color: rgba(204, 225, 234, .9);
            background: var(--fs-surface);
            box-shadow: 0 3px 10px rgba(34, 77, 97, .09);
        }

        .login-mode input:focus-visible + label {
            outline: 3px solid rgba(8, 142, 204, .2);
            outline-offset: 1px;
        }

        .field-group { margin-bottom: 18px; }

        .field-label {
            display: block;
            margin-bottom: 8px;
            color: #314b5b;
            font-size: 12px;
            font-weight: 700;
        }

        .field-wrap {
            position: relative;
            display: flex;
            align-items: center;
        }

        .field-icon {
            position: absolute;
            left: 14px;
            z-index: 1;
            display: grid;
            width: 19px;
            height: 19px;
            place-items: center;
            color: #718895;
            pointer-events: none;
        }

        .field-icon svg, .password-toggle svg { width: 19px; height: 19px; }

        .auth-input {
            width: 100%;
            height: 50px;
            padding: 0 45px 0 44px;
            color: #173445;
            border: 1px solid #ccdce4;
            border-radius: 10px;
            outline: none;
            background: #fbfdfe;
            font-size: 14px;
            transition: border-color .2s ease, box-shadow .2s ease, background-color .2s ease;
        }

        .auth-input::placeholder { color: #9aabb4; }

        .auth-input:hover { border-color: #a9c4d0; }

        .auth-input:focus {
            border-color: var(--fs-primary);
            background: #fff;
            box-shadow: 0 0 0 4px rgba(8, 142, 204, .11);
        }

        .password-toggle {
            position: absolute;
            right: 7px;
            display: grid;
            width: 38px;
            height: 38px;
            padding: 0;
            place-items: center;
            cursor: pointer;
            color: #607986;
            border: 0;
            border-radius: 8px;
            background: transparent;
            transition: color .2s ease, background-color .2s ease;
        }

        .password-toggle:hover { color: var(--fs-primary-deep); background: var(--fs-primary-soft); }
        .password-toggle:focus-visible { outline: 3px solid rgba(8, 142, 204, .2); }
        .eye-off { display: none; }
        .password-toggle.is-visible .eye-on { display: none; }
        .password-toggle.is-visible .eye-off { display: block; }

        .auth-submit {
            width: 100%;
            height: 50px;
            margin-top: 5px;
            cursor: pointer;
            color: #fff;
            border: 1px solid var(--fs-primary-deep) !important;
            border-radius: 10px;
            background: var(--fs-primary) !important;
            box-shadow: 0 10px 22px rgba(8, 126, 174, .22);
            font-size: 14px;
            font-weight: 800;
            letter-spacing: .01em;
            transition: transform .18s ease, background-color .18s ease, box-shadow .18s ease;
        }

        .auth-submit:hover {
            transform: translateY(-1px);
            background: var(--fs-primary-deep) !important;
            box-shadow: 0 13px 26px rgba(8, 93, 132, .25);
        }

        .auth-submit:active { transform: translateY(0); box-shadow: 0 6px 14px rgba(8, 93, 132, .2); }
        .auth-submit:focus-visible { outline: 3px solid rgba(8, 142, 204, .25); outline-offset: 3px; }

        .status-message {
            display: block;
            margin-top: 17px;
            padding: 12px 14px 12px 40px;
            color: var(--fs-danger) !important;
            border: 1px solid #f3c8c3;
            border-radius: 10px;
            background: var(--fs-danger-bg);
            font-size: 13px;
            font-weight: 600;
            line-height: 1.5;
        }

        .status-wrap { position: relative; }

        .status-wrap:has(.status-message)::before {
            content: "!";
            position: absolute;
            z-index: 1;
            top: 27px;
            left: 15px;
            display: grid;
            width: 17px;
            height: 17px;
            place-items: center;
            color: #fff;
            border-radius: 50%;
            background: var(--fs-danger);
            font-size: 11px;
            font-weight: 800;
        }

        .register-row {
            margin-top: 22px;
            padding-top: 20px;
            text-align: center;
            border-top: 1px solid #e7eff2;
            color: var(--fs-muted);
            font-size: 13px;
        }

        .registration-option { display: none; }
        .registration-option.is-active { display: block; animation: fade-in .22s ease both; }

        .registration-link {
            margin-left: 3px;
            color: var(--fs-primary-deep) !important;
            font-weight: 800;
            text-decoration: none;
        }

        .registration-link:hover { color: var(--fs-primary) !important; text-decoration: underline; text-underline-offset: 3px; }

        .secure-note {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            margin-top: 18px;
            color: #82939d;
            font-size: 11px;
        }

        .secure-note svg { width: 14px; height: 14px; }

        .child-menu { display: none; }
        .parent-menu:hover .child-menu { display: block; }

        @keyframes fade-in {
            from { opacity: 0; transform: translateY(3px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 1023px) {
            .auth-main { padding-top: 130px; }
            .auth-layout { max-width: 520px; grid-template-columns: 1fr; gap: 34px; }
            .auth-intro { text-align: center; margin: 0 auto; }
            .auth-eyebrow { margin-bottom: 14px; }
            .auth-title { font-size: 39px; }
            .auth-copy { margin: 14px auto 0; }
            .trust-list { display: none; }
        }

        @media (max-width: 560px) {
            .auth-main { min-height: 650px; padding: 122px 14px 44px; }
            .auth-layout { gap: 25px; }
            .auth-title { font-size: 31px; }
            .auth-copy { font-size: 14px; line-height: 1.65; }
            .auth-card { border-radius: 16px; }
            .auth-card-inner { padding: 26px 20px 27px; }
            .auth-card-heading h2 { font-size: 22px; }
            .auth-input, .auth-submit { height: 48px; }
        }

        @media (prefers-reduced-motion: reduce) {
            html { scroll-behavior: auto; }
            *, *::before, *::after { animation-duration: .01ms !important; transition-duration: .01ms !important; }
        }
    </style>
</head>
<body class="bg-[#F3F3F3]">
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
                        <a href="Home.aspx" class="max-w-full text-white font-bold text-[22px]">
                            FlipShop
                        </a>
                    </div>
                    <!-- Search -->
                    <div class="search-container w-[55%] h-9 mr-10 rounded bg-white hidden md:hidden sm:hidden lg:block">
                        <div class="search-box h-10 flex">
                            <input type="text"
                                   class="w-full p-0 border-none border-transparent focus:border-transparent focus:ring-0"
                                   placeholder="Search essentials, groceries, and more â€¦">
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
                               placeholder="Search essentials, groceries, and more â€¦">
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

        <!-- Login Section -->
        <main class="auth-main">
            <div class="auth-layout">
                <section class="auth-intro" aria-labelledby="login-title">
                    <div class="auth-eyebrow">Secure account access</div>
                    <h1 id="login-title" class="auth-title">Welcome back to FlipShop.</h1>
                    <p class="auth-copy">Sign in to manage your orders, save your favourites, and continue shopping with a faster checkout.</p>
                    <ul class="trust-list" aria-label="Account benefits">
                        <li>
                            <span class="trust-icon" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m5 12 4 4L19 6"/></svg>
                            </span>
                            Protected account access
                        </li>
                        <li>
                            <span class="trust-icon" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 6h18v13H3z"/><path d="M3 10h18M7 15h3"/></svg>
                            </span>
                            Quick and secure checkout
                        </li>
                        <li>
                            <span class="trust-icon" aria-hidden="true">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 12h18M12 3v18"/><circle cx="12" cy="12" r="9"/></svg>
                            </span>
                            One account for every order
                        </li>
                    </ul>
                </section>

                <section class="auth-card" aria-labelledby="signin-heading">
                    <div class="auth-card-inner">
                        <div class="auth-card-heading">
                            <h2 id="signin-heading">Sign in</h2>
                            <p>Choose your account type and enter your details.</p>
                        </div>

                        <label class="login-mode-label">Sign in as</label>
                        <asp:RadioButtonList
                            ID="RadioButtonList1"
                            runat="server"
                            RepeatDirection="Horizontal"
                            AutoPostBack="True"
                            OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged"
                            Width="127px"
                            CssClass="login-mode"
                            aria-label="Choose account type">
                            <asp:ListItem Text="Customer" Value="User" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                        </asp:RadioButtonList>

                        <asp:Panel ID="UserPanel" runat="server">
                            <div class="field-group">
                                <label class="field-label" for="<%= TextBox1.ClientID %>">Username</label>
                                <div class="field-wrap">
                                    <span class="field-icon" aria-hidden="true">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="8" r="4"/><path d="M4.5 21a7.5 7.5 0 0 1 15 0"/></svg>
                                    </span>
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="auth-input" placeholder="Enter your username" autocomplete="username"></asp:TextBox>
                                </div>
                            </div>
                            <div class="field-group">
                                <label class="field-label" for="<%= TextBox2.ClientID %>">Password</label>
                                <div class="field-wrap">
                                    <span class="field-icon" aria-hidden="true">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="4" y="10" width="16" height="11" rx="2"/><path d="M8 10V7a4 4 0 0 1 8 0v3"/></svg>
                                    </span>
                                    <asp:TextBox ID="TextBox2" runat="server" TextMode="Password" CssClass="auth-input" placeholder="Enter your password" autocomplete="current-password"></asp:TextBox>
                                    <button type="button" id="passwordToggle" class="password-toggle" aria-label="Show password" aria-pressed="false">
                                        <svg class="eye-on" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M2 12s3.5-6 10-6 10 6 10 6-3.5 6-10 6S2 12 2 12Z"/><circle cx="12" cy="12" r="2.5"/></svg>
                                        <svg class="eye-off" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="m3 3 18 18M10.6 10.7a2 2 0 0 0 2.7 2.7M9.9 5.1A10.8 10.8 0 0 1 12 5c6.5 0 10 7 10 7a18 18 0 0 1-2.1 3.1M6.2 6.2C3.5 8 2 12 2 12s3.5 7 10 7a9.8 9.8 0 0 0 3.8-.8"/></svg>
                                    </button>
                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="AdminPanel" runat="server" Visible="false">
                            <div class="field-group">
                                <label class="field-label" for="<%= TextBox3.ClientID %>">Admin name</label>
                                <div class="field-wrap">
                                    <span class="field-icon" aria-hidden="true">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="8" r="4"/><path d="M4.5 21a7.5 7.5 0 0 1 15 0"/></svg>
                                    </span>
                                    <asp:TextBox ID="TextBox3" runat="server" CssClass="auth-input" placeholder="Enter admin name" autocomplete="username"></asp:TextBox>
                                </div>
                            </div>
                            <div class="field-group">
                                <label class="field-label" for="<%= TextBox4.ClientID %>">Admin email</label>
                                <div class="field-wrap">
                                    <span class="field-icon" aria-hidden="true">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="m3 7 9 6 9-6"/></svg>
                                    </span>
                                    <asp:TextBox ID="TextBox4" runat="server" CssClass="auth-input" placeholder="Enter admin email" TextMode="Email" autocomplete="email"></asp:TextBox>
                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Button
                            ID="Button1"
                            runat="server"
                            OnClick="Button1_Click"
                            Text="Sign In"
                            CssClass="auth-submit" />

                        <div class="status-wrap" role="status" aria-live="polite">
                            <asp:Label
                                ID="Label1"
                                runat="server"
                                Text=""
                                Visible="False"
                                CssClass="status-message">
                            </asp:Label>
                        </div>

                        <div class="register-row">
                            <div id="customerRegistration" class="registration-option">
                                New to FlipShop?
                                <asp:HyperLink
                                    ID="HyperLink1"
                                    runat="server"
                                    NavigateUrl="User.aspx"
                                    Text="Create customer account"
                                    CssClass="registration-link">
                                </asp:HyperLink>
                            </div>
                            <div id="adminRegistration" class="registration-option">
                                Need admin access?
                                <asp:HyperLink
                                    ID="HyperLink2"
                                    runat="server"
                                    NavigateUrl="~/AdminReg.aspx"
                                    CssClass="registration-link">Register as admin</asp:HyperLink>
                            </div>
                        </div>

                        <div class="secure-note">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><rect x="4" y="10" width="16" height="11" rx="2"/><path d="M8 10V7a4 4 0 0 1 8 0v3"/></svg>
                            Your sign-in details are securely protected
                        </div>
                    </div>
                </section>
            </div>
        </main>

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
                <p class="text-[13px]">Â© 2022 All rights reserved.</p>
            </div>
        </footer>

    </form>

    <script src="./assets/js/jquery-3.6.0.min.js"></script>
    <script src="./assets/js/main.js"></script>
    <script type="text/javascript">
        (function () {
            function updateAccountMode() {
                var selector = document.getElementById('<%= RadioButtonList1.ClientID %>');
                var customerRegistration = document.getElementById('customerRegistration');
                var adminRegistration = document.getElementById('adminRegistration');
                if (!selector || !customerRegistration || !adminRegistration) return;

                var selected = selector.querySelector('input:checked');
                var isAdmin = selected && selected.value === 'Admin';
                customerRegistration.classList.toggle('is-active', !isAdmin);
                adminRegistration.classList.toggle('is-active', !!isAdmin);
            }

            function setupPasswordToggle() {
                var toggle = document.getElementById('passwordToggle');
                var password = document.getElementById('<%= TextBox2.ClientID %>');
                if (!toggle || !password) return;

                toggle.addEventListener('click', function () {
                    var showPassword = password.type === 'password';
                    password.type = showPassword ? 'text' : 'password';
                    toggle.classList.toggle('is-visible', showPassword);
                    toggle.setAttribute('aria-pressed', showPassword ? 'true' : 'false');
                    toggle.setAttribute('aria-label', showPassword ? 'Hide password' : 'Show password');
                    password.focus();
                });
            }

            document.addEventListener('DOMContentLoaded', function () {
                updateAccountMode();
                setupPasswordToggle();
            });
        }());
    </script>
</body>
</html>

