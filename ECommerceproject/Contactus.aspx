<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contactus.aspx.cs" Inherits="ECommerceproject.Contactus" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="./assets/css/output.css" rel="stylesheet" />
    <link href="./assets/css/custom.css" rel="stylesheet" />
    <title>Contact Us | FlipShop</title>
    <style type="text/css">
        :root{--fs-blue:#008ECC;--fs-blue-d:#0070a3;--fs-ink:#1f2937;--fs-muted:#6b7280;--fs-line:#e5e7eb;--fs-ok:#15803d;--fs-err:#dc2626}
        .cu-page{max-width:1100px;margin:0 auto;padding:150px 16px 24px}
        @media(min-width:1024px){.cu-page{padding-top:130px}}
        .cu-head h1{font-size:30px;font-weight:700;color:var(--fs-ink);margin:0}
        .cu-head p{color:var(--fs-muted);margin:6px 0 0;font-size:15px;max-width:560px}
        .cu-crumb{font-size:13px;color:var(--fs-muted);margin-bottom:10px}.cu-crumb a{color:var(--fs-blue)}
        .cu-grid{display:grid;grid-template-columns:minmax(0,1fr);gap:24px;margin-top:24px}.cu-card,.cu-shell{box-sizing:border-box;min-width:0}
        @media(min-width:900px){.cu-grid{grid-template-columns:minmax(0,1.6fr) minmax(0,1fr)}}
        .cu-card{background:#fff;border:1px solid var(--fs-line);border-radius:14px;padding:28px;box-shadow:0 6px 24px -16px rgba(0,60,100,.25)}
        @media(max-width:560px){.cu-card{padding:20px}}
        .cu-card h2{font-size:18px;font-weight:700;color:var(--fs-ink);margin:0 0 4px}
        .cu-card .cu-sub{color:var(--fs-muted);font-size:14px;margin:0 0 20px}
        .cu-field{margin-bottom:18px}
        .cu-label{display:flex;justify-content:space-between;font-size:14px;font-weight:600;color:var(--fs-ink);margin-bottom:6px}
        .cu-label small{font-weight:500;color:var(--fs-muted)}
        .cu-shell{display:flex;align-items:center;gap:10px;border:1px solid #d1d5db;border-radius:10px;background:#fff;padding:0 12px;transition:border-color .15s,box-shadow .15s}
        .cu-shell:hover{border-color:#9ca3af}
        .cu-shell:focus-within{border-color:var(--fs-blue);box-shadow:0 0 0 3px rgba(0,142,204,.18)}
        .cu-shell svg{flex-shrink:0;color:var(--fs-muted)}
        .cu-shell input,.cu-shell textarea{flex:1;min-width:0;border:0;outline:0;background:transparent;font-size:15px;color:var(--fs-ink);padding:12px 0;font-family:inherit}
        .cu-shell textarea{min-height:170px;resize:vertical;align-self:stretch}
        .cu-shell.ta{align-items:flex-start}.cu-shell.ta svg{margin-top:13px}
        .cu-shell.ro{background:#f3f7fa;border-style:dashed}
        .cu-shell.ro input{color:#374151;cursor:not-allowed}
        .cu-pill{font-size:11px;font-weight:600;color:var(--fs-blue);background:#e6f4fb;border-radius:999px;padding:3px 8px;display:inline-flex;gap:4px;align-items:center;white-space:nowrap}
        .cu-shell.bad{border-color:var(--fs-err);box-shadow:0 0 0 3px rgba(220,38,38,.12)}
        .cu-err{display:none;color:var(--fs-err);font-size:13px;margin-top:6px;align-items:center;gap:6px}
        .cu-err.on{display:flex}
        .cu-meta{display:flex;justify-content:space-between;font-size:12px;color:var(--fs-muted);margin-top:6px}
        .cu-btn{display:inline-flex;align-items:center;justify-content:center;gap:8px;width:100%;background:var(--fs-blue);color:#fff;font-weight:600;font-size:15px;border:0;border-radius:10px;padding:13px 20px;cursor:pointer;transition:background .15s,transform .1s,box-shadow .15s;text-decoration:none}
        .cu-btn:hover{background:var(--fs-blue-d);box-shadow:0 8px 18px -10px rgba(0,112,163,.8)}
        .cu-btn:active{transform:translateY(1px)}
        .cu-btn:focus-visible{outline:3px solid rgba(0,142,204,.4);outline-offset:2px}
        .cu-btn[disabled]{opacity:.75;cursor:progress}
        .cu-btn.ghost{background:#fff;color:var(--fs-err);border:1px solid #fca5a5;width:auto;padding:8px 14px;font-size:14px}
        .cu-btn.ghost:hover{background:#fef2f2;box-shadow:none}
        .cu-spin{width:16px;height:16px;border:2px solid rgba(255,255,255,.45);border-top-color:#fff;border-radius:50%;animation:cuspin .8s linear infinite;display:none}
        .is-busy .cu-spin{display:inline-block}
        @keyframes cuspin{to{transform:rotate(360deg)}}
        .cu-note{display:flex;gap:8px;align-items:center;justify-content:center;font-size:13px;color:var(--fs-muted);margin-top:12px;text-align:center}
        .cu-alert{display:none;gap:12px;border-radius:12px;padding:14px 16px;margin-bottom:18px;font-size:14px}
        .cu-alert.on{display:flex}
        .cu-alert strong{display:block;font-size:15px;margin-bottom:2px}
        .cu-alert.ok{background:#f0fdf4;border:1px solid #bbf7d0;color:#14532d}
        .cu-alert.fail{background:#fef2f2;border:1px solid #fecaca;color:#7f1d1d}
        .cu-alert svg{flex-shrink:0;margin-top:2px}
        .cu-steps{list-style:none;padding:0;margin:0}
        .cu-steps li{display:flex;gap:12px;padding:12px 0;border-bottom:1px solid var(--fs-line);font-size:14px;color:#374151}
        .cu-steps li:last-child{border-bottom:0}
        .cu-num{flex-shrink:0;width:28px;height:28px;border-radius:50%;background:#e6f4fb;color:var(--fs-blue);font-weight:700;display:grid;place-items:center;font-size:13px}
        .cu-info{margin-top:18px;padding-top:16px;border-top:1px solid var(--fs-line);font-size:14px;color:#374151}
        .cu-info div{display:flex;gap:10px;align-items:flex-start;margin-bottom:10px}
        .cu-info svg{color:var(--fs-blue);flex-shrink:0;margin-top:2px}
        .cu-ph{font-size:11px;color:var(--fs-muted);font-style:italic}
        @media(prefers-reduced-motion:reduce){*{transition:none!important;animation:none!important}}
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

        <main class="cu-page">
            <div class="cu-head">
                <div class="cu-crumb"><a href="Home.aspx">Home</a> / Contact Us</div>
                <h1>Contact Us</h1>
                <p>We value your feedback. Let us know how we can improve your shopping experience.</p>
            </div>

            <div class="cu-grid">
                <section class="cu-card" aria-labelledby="cuFormTitle">
                    <h2 id="cuFormTitle">Send feedback</h2>
                    <p class="cu-sub">Share a suggestion, report a problem, or tell us what you liked.</p>

                    <div id="cuSuccess" runat="server" clientidmode="Static" class="cu-alert ok" role="status" aria-live="polite">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="m8 12 3 3 5-6"/></svg>
                        <div><strong>Thank you! Your feedback has been submitted.</strong>Our support team will review it shortly.</div>
                    </div>
                    <div id="cuFail" runat="server" clientidmode="Static" class="cu-alert fail" role="alert">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="M12 8v5M12 16h.01"/></svg>
                        <div style="flex:1"><strong id="cuFailTitle" runat="server">We couldn't send your feedback.</strong> <span id="cuFailMsg" runat="server">Something went wrong on our side. Your message is still here — please try again.</span></div>
                    </div>

                    <div id="cuForm">
                        <div class="cu-field">
                            <label class="cu-label" for="txtEmail">Email <small>Registered account</small></label>
                            <div class="cu-shell ro">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21a8 8 0 0 1 16 0"/></svg>
                                <asp:TextBox ID="txtEmail" runat="server" ReadOnly="true" ClientIDMode="Static" aria-describedby="cuEmailHint"></asp:TextBox>
                                <span class="cu-pill"><svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><rect x="5" y="11" width="14" height="10" rx="2"/><path d="M8 11V7a4 4 0 0 1 8 0v4"/></svg>Locked</span>
                            </div>
                            <div class="cu-meta" id="cuEmailHint"><span>We'll reply to the email on your account.</span></div>
                        </div>

                        <div class="cu-field">
                            <label class="cu-label" for="txtSubject">Subject</label>
                            <div class="cu-shell" id="shSubject">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 6h16M4 12h10M4 18h7"/></svg>
                                <asp:TextBox ID="txtSubject" runat="server" MaxLength="150" ClientIDMode="Static" placeholder="e.g. Delivery was late for my last order" aria-describedby="errSubject"></asp:TextBox>
                            </div>
                            <div class="cu-err" id="errSubject"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"/><path d="M12 8v5M12 16h.01"/></svg>Please enter a subject.</div>
                        </div>

                        <div class="cu-field">
                            <label class="cu-label" for="txtMessage">Feedback message</label>
                            <div class="cu-shell ta" id="shMessage">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
                                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" MaxLength="1000" ClientIDMode="Static" placeholder="Tell us what happened or what we could do better. Include an order ID if it's about a specific order." aria-describedby="errMessage cuCount"></asp:TextBox>
                            </div>
                            <div class="cu-err" id="errMessage"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"/><path d="M12 8v5M12 16h.01"/></svg>Please write your feedback message.</div>
                            <div class="cu-meta"><span>Be as specific as you can.</span><span id="cuCount">0 / 1000</span></div>
                        </div>

                        <asp:LinkButton ID="btnSubmitFeedback" runat="server" CssClass="cu-btn" ClientIDMode="Static"
                            OnClick="btnSubmitFeedback_Click" OnClientClick="return cuHandleSubmit();">
                            <span class="cu-spin" aria-hidden="true"></span>
                            <span id="cuBtnText">Submit Feedback</span>
                        </asp:LinkButton>
                        <p class="cu-note">
                            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
                            Your feedback will be reviewed by our support team.
                        </p>
                    </div>
                </section>

                <aside class="cu-card" aria-labelledby="cuNextTitle">
                    <h2 id="cuNextTitle">What happens next</h2>
                    <p class="cu-sub">Here's how we handle your message.</p>
                    <ol class="cu-steps">
                        <li><span class="cu-num">1</span><span>Your feedback reaches our support team.</span></li>
                        <li><span class="cu-num">2</span><span>We review it and look into any order issues.</span></li>
                        <li><span class="cu-num">3</span><span>If needed, we reply to your registered email.</span></li>
                    </ol>
                    <div class="cu-info">
                        <div><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 4h16v16H4z"/><path d="m4 6 8 7 8-7"/></svg><span>info@example.com</span></div>
                        <div><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.9v3a2 2 0 0 1-2.2 2 19.8 19.8 0 0 1-8.6-3.1 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.1 4.2 2 2 0 0 1 4.1 2h3a2 2 0 0 1 2 1.7c.1 1 .4 1.9.7 2.8a2 2 0 0 1-.5 2.1L8 9.9a16 16 0 0 0 6 6l1.3-1.3a2 2 0 0 1 2.1-.4c.9.3 1.8.6 2.8.7a2 2 0 0 1 1.7 2z"/></svg><span>(987) 654-3210</span></div>
                        <div><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s7-6 7-12a7 7 0 0 0-14 0c0 6 7 12 7 12z"/><circle cx="12" cy="10" r="2.5"/></svg><span>Widgetify Inc., Gadget Avenue, Techtown</span></div>
                       
                    </div>
                </aside>
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
    (function(){
        var $=function(i){return document.getElementById(i)};
        var subj=$('txtSubject'),msg=$('txtMessage'),btn=$('btnSubmitFeedback'),txt=$('cuBtnText');
        function err(f,sh,e,on){var el=$(sh); if(el) el.classList.toggle('bad',on); var er=$(e); if(er) er.classList.toggle('on',on); var inp=$(f); if(inp) inp.setAttribute('aria-invalid',on?'true':'false')}
        function count(){var c=$('cuCount'); if(c&&msg) c.textContent=msg.value.length+' / 1000'}
        function busy(on){
            if(!btn) return;
            btn.disabled = on;
            if(on){
                btn.setAttribute('disabled','disabled');
            } else {
                btn.removeAttribute('disabled');
            }
            btn.classList.toggle('is-busy', on);
            if(txt) txt.textContent = on ? 'Submitting...' : 'Submit Feedback';
        }
        function validate(){
            if(!subj||!msg) return false;
            var a=!subj.value.trim(), b=!msg.value.trim();
            err('txtSubject','shSubject','errSubject',a);
            err('txtMessage','shMessage','errMessage',b);
            if(a) subj.focus(); else if(b) msg.focus();
            return !(a||b);
        }
        if(msg) msg.addEventListener('input',function(){count();if(msg.value.trim())err('txtMessage','shMessage','errMessage',false)});
        if(subj) subj.addEventListener('input',function(){if(subj.value.trim())err('txtSubject','shSubject','errSubject',false)});

        window.cuHandleSubmit = function(){
            if(btn && btn.hasAttribute('disabled')) return false;
            var succ=$('cuSuccess'), fail=$('cuFail');
            if(succ) succ.classList.remove('on');
            if(fail) fail.classList.remove('on');
            if(!validate()) return false;
            busy(true);
            return true;
        };
    })();
    </script>
    <script src="./assets/js/jquery-3.6.0.min.js"></script>
    <script src="./assets/js/main.js"></script>
</body>
</html>
