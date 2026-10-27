<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Category.aspx.cs" Inherits="ECommerceproject.Category" %>





<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="./assets/css/output.css" rel="stylesheet">
    <link href="./assets/css/custom.css" rel="stylesheet" />
    <link href="./assets/css/owlcarousel/owl.carousel.min.css" rel="stylesheet">
    <link href="./assets/css/owlcarousel/owl.theme.default.min.css" rel="stylesheet">
    <title>Add Category — FlipShop Admin</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&amp;family=Space+Grotesk:wght@500;600;700&amp;display=swap" rel="stylesheet">
    <style type="text/css">
        :root {
            --admin-bg: #f4faf9;
            --admin-surface: #ffffff;
            --admin-primary: #0f8a83;
            --admin-primary-dark: #145e63;
            --admin-ink: #1f3437;
            --admin-muted: #5b7470;
            --admin-line: #dce9e7;
            --admin-soft: rgba(15, 138, 131, .1);
            --admin-danger: #d64545;
            --admin-danger-soft: rgba(214, 69, 69, .09);
            --admin-shadow: 0 18px 44px rgba(20, 94, 99, .12);
        }

        * { box-sizing: border-box; }
        html { scroll-behavior: smooth; }
        body {
            min-width: 320px;
            margin: 0;
            color: var(--admin-ink);
            background: var(--admin-bg) !important;
            font-family: "DM Sans", Arial, sans-serif;
            -webkit-font-smoothing: antialiased;
        }
        a { color: inherit; }
        button, input { font: inherit; }
        .child-menu { display: none; }
        .parent-menu:hover .child-menu { display: block; }

        /* Preserve the existing FlipShop header while bringing it into the admin palette. */
        form > header { background: #008ecc !important; }
        form > header + div { background: rgba(11, 18, 32, .97) !important; }

        .admin-page {
            min-height: 760px;
            padding: 128px 22px 64px;
            background:
                linear-gradient(rgba(15, 138, 131, .05) 1px, transparent 1px),
                linear-gradient(90deg, rgba(15, 138, 131, .05) 1px, transparent 1px),
                var(--admin-bg);
            background-size: 32px 32px;
        }
        .admin-shell {
            display: grid;
            grid-template-columns: 232px minmax(0, 1fr);
            width: 100%;
            max-width: 1280px;
            min-height: 660px;
            margin: 0 auto;
            overflow: hidden;
            border: 1px solid var(--admin-line);
            border-radius: 18px;
            background: var(--admin-surface);
            box-shadow: var(--admin-shadow);
        }
        .admin-sidebar {
            display: flex;
            flex-direction: column;
            min-width: 0;
            padding: 24px 16px 18px;
            color: #cde4e2;
            background: #145e63;
        }
        .sidebar-heading {
            display: flex;
            align-items: center;
            gap: 11px;
            min-height: 44px;
            padding: 0 10px 22px;
            border-bottom: 1px solid rgba(255,255,255,.14);
        }
        .sidebar-mark {
            display: grid;
            width: 36px;
            height: 36px;
            flex: 0 0 36px;
            place-items: center;
            border-radius: 8px;
            color: #ffffff;
            background: var(--admin-primary);
        }
        .sidebar-mark svg, .nav-icon svg, .button-icon svg, .heading-icon svg { width: 20px; height: 20px; }
        .sidebar-title {
            font-family: "Space Grotesk", Arial, sans-serif;
            font-size: 15px;
            font-weight: 700;
            color: #ffffff;
        }
        .sidebar-caption { margin-top: 1px; color: rgba(205, 228, 226, .75); font-size: 11px; }
        .sidebar-label {
            margin: 22px 10px 9px;
            color: rgba(205, 228, 226, .6);
            font-size: 10px;
            font-weight: 700;
            letter-spacing: .12em;
            text-transform: uppercase;
        }
        .sidebar-nav { display: grid; gap: 5px; }
        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 11px;
            min-height: 43px;
            padding: 0 11px;
            color: #bfd9d6 !important;
            border: 1px solid transparent;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            transition: color .18s ease, background-color .18s ease, border-color .18s ease;
        }
        .sidebar-link:hover, .sidebar-link:focus-visible {
            color: #fff !important;
            border-color: rgba(255,255,255,.16);
            background: rgba(255,255,255,.08);
            outline: none;
        }
        .sidebar-link.is-active { color: #ffffff !important; background: var(--admin-primary); }
        .nav-icon { display: grid; width: 20px; height: 20px; flex: 0 0 20px; place-items: center; }
        .sidebar-logout { margin-top: auto; padding-top: 22px; }
        .sidebar-logout .sidebar-link { color: #f2b4b0 !important; }
        .sidebar-logout .sidebar-link:hover { color: #fff !important; background: rgba(214, 69, 69, .22); }

        .admin-workspace { min-width: 0; padding: 34px 38px 42px; }
        .workspace-header {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            gap: 24px;
            margin-bottom: 30px;
        }
        .mobile-sidebar-toggle {
            display: none;
            width: 42px;
            height: 42px;
            padding: 0;
            place-items: center;
            color: var(--admin-ink);
            border: 1px solid var(--admin-line);
            border-radius: 8px;
            background: var(--admin-surface);
            cursor: pointer;
        }
        .mobile-sidebar-toggle svg { width: 21px; height: 21px; }
        .dashboard-eyebrow {
            margin-bottom: 7px;
            color: var(--admin-primary);
            font-size: 11px;
            font-weight: 700;
            letter-spacing: .1em;
            text-transform: uppercase;
        }
        .dashboard-title {
            margin: 0;
            color: var(--admin-ink);
            font-family: "Space Grotesk", Arial, sans-serif;
            font-size: clamp(26px, 3vw, 36px);
            font-weight: 700;
            line-height: 1.15;
            letter-spacing: 0;
        }
        .dashboard-subtitle { margin: 8px 0 0; color: var(--admin-muted); font-size: 14px; }
        .primary-action {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            min-height: 44px;
            padding: 0 17px;
            white-space: nowrap;
            color: #ffffff !important;
            border: 1px solid rgba(15, 138, 131, .5);
            border-radius: 8px;
            background: var(--admin-primary);
            box-shadow: 0 8px 18px rgba(15, 138, 131, .22);
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
            transition: transform .18s ease, background-color .18s ease, box-shadow .18s ease;
        }
        .primary-action:hover { transform: translateY(-1px); background: var(--admin-primary-dark); box-shadow: 0 11px 22px rgba(20, 94, 99, .26); }
        .primary-action:focus-visible { outline: 3px solid rgba(15, 138, 131, .3); outline-offset: 3px; }

        .workspace-summary {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 14px;
            margin-bottom: 30px;
        }
        .summary-item {
            display: flex;
            align-items: center;
            gap: 14px;
            min-height: 86px;
            padding: 17px 19px;
            border: 1px solid var(--admin-line);
            border-radius: 10px;
            background: #f2f9f8;
        }
        .summary-icon {
            display: grid;
            width: 42px;
            height: 42px;
            flex: 0 0 42px;
            place-items: center;
            color: var(--admin-primary);
            border-radius: 8px;
            background: var(--admin-soft);
        }
        .summary-icon svg { width: 21px; height: 21px; }
        .summary-title { margin: 0 0 3px; font-size: 13px; font-weight: 700; }
        .summary-copy { margin: 0; color: var(--admin-muted); font-size: 12px; line-height: 1.45; }

        .products-section { min-width: 0; }
        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            margin-bottom: 13px;
        }
        .section-heading {
            display: flex;
            align-items: center;
            gap: 9px;
            margin: 0;
            color: var(--admin-ink);
            font-family: "Space Grotesk", Arial, sans-serif;
            font-size: 18px;
            font-weight: 700;
        }
        .heading-icon { display: grid; color: var(--admin-primary); place-items: center; }
        .section-note { color: var(--admin-muted); font-size: 12px; }
        .product-grid-wrapper {
            max-width: 100%;
            overflow-x: auto;
            border: 1px solid var(--admin-line);
            border-radius: 10px;
            background: var(--admin-surface);
        }
        .product-grid {
            width: 100%;
            min-width: 680px;
            border-collapse: collapse;
            font-family: "DM Sans", Arial, sans-serif;
            font-size: 13px;
        }
        .product-grid th {
            padding: 13px 18px;
            color: #5b7470;
            border-bottom: 1px solid var(--admin-line);
            background: #f2f9f8;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: .09em;
            text-align: left;
            text-transform: uppercase;
        }
        .product-grid td {
            padding: 13px 18px;
            color: #2c4547;
            border-bottom: 1px solid #e4eeec;
            vertical-align: middle;
        }
        .product-grid tr:last-child td { border-bottom: 0; }
        .product-grid tr.alt-row { background: rgba(15, 138, 131, .04); }
        .product-grid tr:hover td { background: rgba(15, 138, 131, .08); }
        .product-grid .empty-row td { padding: 44px 20px; color: var(--admin-muted); text-align: center; }
        .product-thumb {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border: 1px solid var(--admin-line);
            border-radius: 8px;
            background: #eaf3f1;
        }
        .btn-edit, .btn-delete {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 32px;
            padding: 0 11px;
            border-radius: 7px;
            font-size: 12px;
            font-weight: 700;
            text-decoration: none;
            transition: background-color .18s ease, border-color .18s ease, color .18s ease;
        }
        .btn-edit { color: var(--admin-primary) !important; border: 1px solid rgba(15, 138, 131, .35); background: var(--admin-soft); }
        .btn-edit:hover { border-color: rgba(15, 138, 131, .6); background: rgba(15, 138, 131, .16); }
        .btn-delete { margin-left: 6px; color: #c93a3a !important; border: 1px solid rgba(214, 69, 69, .35); background: var(--admin-danger-soft); }
        .btn-delete:hover { border-color: rgba(214, 69, 69, .6); background: rgba(214, 69, 69, .16); }
        .btn-edit:focus-visible, .btn-delete:focus-visible { outline: 3px solid rgba(15, 138, 131, .25); outline-offset: 2px; }
        .sidebar-backdrop { display: none; }

        @media (max-width: 1023px) {
            .admin-page { padding-top: 118px; }
            .admin-shell { grid-template-columns: 1fr; overflow: visible; }
            .admin-sidebar {
                position: fixed;
                z-index: 70;
                top: 0;
                bottom: 0;
                left: 0;
                width: 250px;
                transform: translateX(-102%);
                box-shadow: 18px 0 45px rgba(20, 94, 99, .35);
                transition: transform .22s ease;
            }
            .admin-shell.sidebar-open .admin-sidebar { transform: translateX(0); }
            .sidebar-backdrop {
                position: fixed;
                z-index: 60;
                inset: 0;
                display: block;
                visibility: hidden;
                opacity: 0;
                border: 0;
                background: rgba(20, 94, 99, .4);
                transition: opacity .22s ease, visibility .22s ease;
            }
            .admin-shell.sidebar-open .sidebar-backdrop { visibility: visible; opacity: 1; }
            .mobile-sidebar-toggle { display: grid; }
            .workspace-heading { display: flex; align-items: center; gap: 13px; }
            .admin-workspace { padding: 28px; }
        }
        @media (max-width: 640px) {
            .admin-page { padding: 108px 12px 36px; }
            .admin-shell { border-radius: 12px; }
            .admin-workspace { padding: 22px 16px 28px; }
            .workspace-header { align-items: flex-start; margin-bottom: 23px; }
            .dashboard-title { font-size: 27px; }
            .dashboard-subtitle { max-width: 220px; font-size: 13px; }
            .primary-action { width: 44px; min-width: 44px; padding: 0; }
            .primary-action .action-label { position: absolute; width: 1px; height: 1px; overflow: hidden; clip: rect(0,0,0,0); }
            .workspace-summary { grid-template-columns: 1fr; gap: 10px; }
            .summary-item { min-height: 76px; padding: 14px; }
            .section-note { display: none; }
        }
        @media (prefers-reduced-motion: reduce) {
            html { scroll-behavior: auto; }
            *, *::before, *::after { transition-duration: .01ms !important; animation-duration: .01ms !important; }
        }

        /* ---- Add Category form ---- */
        .form-layout { display: grid; grid-template-columns: minmax(0, 1fr) 300px; gap: 22px; align-items: start; }
        .form-card {
            padding: 26px 26px 28px;
            border: 1px solid var(--admin-line);
            border-radius: 12px;
            background: var(--admin-surface);
            box-shadow: 0 10px 26px rgba(20, 94, 99, .07);
        }
        .form-field { margin-bottom: 20px; }
        .form-field label,
        .form-field span.field-label {
            display: block;
            margin-bottom: 7px;
            color: var(--admin-ink);
            font-size: 12px;
            font-weight: 700;
            letter-spacing: .04em;
            text-transform: uppercase;
        }
        .field-input {
            width: 100%;
            min-height: 44px;
            padding: 0 13px;
            color: var(--admin-ink);
            border: 1px solid var(--admin-line);
            border-radius: 8px;
            background: #fbfefd;
            font-size: 14px;
            transition: border-color .18s ease, box-shadow .18s ease;
        }
        .field-input:focus {
            border-color: var(--admin-primary);
            box-shadow: 0 0 0 3px rgba(15, 138, 131, .16);
            outline: none;
        }
        .field-hint { margin: 7px 0 0; color: var(--admin-muted); font-size: 12px; }
        .file-field {
            padding: 16px;
            border: 1px dashed rgba(15, 138, 131, .4);
            border-radius: 10px;
            background: rgba(15, 138, 131, .05);
        }
        .file-field input[type="file"] { max-width: 100%; color: var(--admin-ink); font-size: 13px; }
        .file-field input[type="file"]::file-selector-button {
            margin-right: 11px;
            min-height: 34px;
            padding: 0 13px;
            color: #fff;
            border: 0;
            border-radius: 7px;
            background: var(--admin-primary);
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
        }
        .form-actions { display: flex; align-items: center; gap: 14px; flex-wrap: wrap; margin-top: 26px; padding-top: 20px; border-top: 1px solid var(--admin-line); }
        .submit-button {
            min-height: 46px;
            padding: 0 22px;
            color: #ffffff !important;
            border: 1px solid rgba(15, 138, 131, .5) !important;
            border-radius: 8px;
            background: var(--admin-primary) !important;
            box-shadow: 0 8px 18px rgba(15, 138, 131, .22);
            font-family: "Space Grotesk", Arial, sans-serif;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: .04em;
            cursor: pointer;
            transition: transform .18s ease, background-color .18s ease;
        }
        .submit-button:hover { transform: translateY(-1px); background: var(--admin-primary-dark) !important; }
        .ghost-link { color: var(--admin-primary) !important; font-size: 13px; font-weight: 700; text-decoration: none; }
        .ghost-link:hover { text-decoration: underline; }
        .status-note {
            display: inline-block;
            margin-top: 18px;
            padding: 11px 15px;
            color: var(--admin-primary-dark) !important;
            border: 1px solid rgba(15, 138, 131, .3);
            border-radius: 8px;
            background: var(--admin-soft);
            font-size: 13px;
            font-weight: 600;
        }
        .guide-card {
            padding: 20px;
            border: 1px solid var(--admin-line);
            border-radius: 12px;
            background: #f2f9f8;
        }
        .guide-title { display: flex; align-items: center; gap: 9px; margin: 0 0 12px; font-family: "Space Grotesk", Arial, sans-serif; font-size: 15px; font-weight: 700; }
        .guide-title svg { width: 19px; height: 19px; color: var(--admin-primary); }
        .guide-list { margin: 0; padding-left: 18px; list-style: disc outside; color: var(--admin-muted); font-size: 13px; line-height: 1.65; }
        /* ---- Category list, filters, table ---- */
        .list-card {
            margin-top: 26px;
            padding: 24px 24px 12px;
            border: 1px solid var(--admin-line);
            border-radius: 14px;
            background: #ffffff;
            box-shadow: 0 18px 40px -32px rgba(20, 94, 99, .5);
        }
        .list-head { display: flex; align-items: flex-end; justify-content: space-between; gap: 18px; flex-wrap: wrap; margin-bottom: 18px; }
        .filter-bar { display: flex; align-items: flex-end; gap: 12px; flex-wrap: wrap; }
        .filter-field { display: flex; flex-direction: column; gap: 6px; }
        .filter-field > label, .filter-label { color: var(--admin-muted); font-size: 11px; font-weight: 700; letter-spacing: .09em; text-transform: uppercase; }
        .filter-input, .filter-select {
            min-height: 42px;
            padding: 0 13px;
            color: var(--admin-ink);
            border: 1px solid var(--admin-line);
            border-radius: 9px;
            background: #fbfefd;
            font-family: "DM Sans", Arial, sans-serif;
            font-size: 13px;
        }
        .filter-input { min-width: 230px; }
        .filter-select { min-width: 150px; }
        .filter-input:focus, .filter-select:focus { outline: none; border-color: var(--admin-primary); box-shadow: 0 0 0 3px rgba(15, 138, 131, .14); }
        .filter-button {
            min-height: 42px;
            padding: 0 18px;
            color: #ffffff !important;
            border: 1px solid rgba(15, 138, 131, .5) !important;
            border-radius: 9px;
            background: var(--admin-primary) !important;
            font-family: "Space Grotesk", Arial, sans-serif;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: .04em;
            cursor: pointer;
        }
        .filter-button:hover { background: var(--admin-primary-dark) !important; }
        .filter-reset {
            min-height: 42px;
            padding: 0 15px;
            color: var(--admin-primary) !important;
            border: 1px solid rgba(15, 138, 131, .35) !important;
            border-radius: 9px;
            background: #ffffff !important;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }
        .table-scroll { overflow-x: auto; }
        .data-table { width: 100%; border-collapse: collapse; font-size: 13px; }
        .data-table th {
            padding: 12px 14px;
            color: var(--admin-muted);
            border-bottom: 1px solid var(--admin-line);
            background: var(--admin-soft);
            font-family: "Space Grotesk", Arial, sans-serif;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: .08em;
            text-transform: uppercase;
            text-align: left;
            white-space: nowrap;
        }
        .data-table td { padding: 14px; color: var(--admin-ink); border-bottom: 1px solid var(--admin-line); vertical-align: middle; }
        .data-table tr:hover td { background: rgba(15, 138, 131, .04); }
        .thumb {
            width: 52px; height: 52px;
            border: 1px solid var(--admin-line);
            border-radius: 9px;
            background: #f6fbfa;
            object-fit: cover;
        }
        .status-pill {
            display: inline-block;
            padding: 5px 11px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 700;
            letter-spacing: .05em;
            text-transform: uppercase;
        }
        .status-pill.is-active { color: #0f6f52; border: 1px solid rgba(16, 143, 106, .3); background: rgba(16, 143, 106, .12); }
        .status-pill.is-inactive { color: #8a5a12; border: 1px solid rgba(184, 124, 26, .3); background: rgba(184, 124, 26, .12); }
        .row-actions { display: inline-flex; align-items: center; gap: 8px; white-space: nowrap; }
        .row-action {
            min-height: 34px;
            padding: 0 12px;
            display: inline-flex;
            align-items: center;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 700;
            text-decoration: none !important;
            cursor: pointer;
        }
        .row-action.is-edit { color: var(--admin-primary-dark) !important; border: 1px solid rgba(15, 138, 131, .35); background: rgba(15, 138, 131, .07); }
        .row-action.is-edit:hover { background: rgba(15, 138, 131, .14); }
        .row-action.is-save { color: #ffffff !important; border: 1px solid rgba(15, 138, 131, .5); background: var(--admin-primary); }
        .row-action.is-cancel { color: var(--admin-muted) !important; border: 1px solid var(--admin-line); background: #ffffff; }
        .row-action.is-delete { color: var(--admin-danger) !important; border: 1px solid rgba(214, 69, 69, .3); background: rgba(214, 69, 69, .08); }
        .row-action.is-delete:hover { background: rgba(214, 69, 69, .16); }
        .empty-state { padding: 34px 14px; color: var(--admin-muted); text-align: center; font-size: 13px; }
        @media (max-width: 1023px) { .form-layout { grid-template-columns: minmax(0, 1fr); } }
        @media (max-width: 640px) {
            .form-card { padding: 20px 16px 22px; }
            .list-card { padding: 18px 14px 6px; }
            .filter-input, .filter-select { min-width: 0; width: 100%; }
            .filter-field { width: 100%; }
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
        <!-- Admin Dashboard Section -->
        <!-- Add Category Section -->
        <main class="admin-page">
            <div id="adminShell" class="admin-shell">
                <button type="button" id="sidebarBackdrop" class="sidebar-backdrop" aria-label="Close admin navigation"></button>
                <aside id="adminSidebar" class="admin-sidebar" aria-label="Admin navigation">
                    <div class="sidebar-heading">
                        <span class="sidebar-mark" aria-hidden="true">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/></svg>
                        </span>
                        <span>
                            <span class="sidebar-title">FlipShop Admin</span>
                            <span class="sidebar-caption">Store operations</span>
                        </span>
                    </div>
                    <div class="sidebar-label">Workspace</div>
                    <nav class="sidebar-nav">
                        <a href="AdminHome.aspx" class="sidebar-link">
                            <span class="nav-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M4 13h6V4H4v9Zm0 7h6v-4H4v4Zm10 0h6v-9h-6v9Zm0-16v4h6V4h-6Z"/></svg></span>
                            Dashboard
                        </a>
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Category.aspx" CssClass="sidebar-link is-active">
                            <span class="nav-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M3 6h7l2 2h9v11H3V6Z"/><path d="M3 10h18"/></svg></span>
                            Add category
                        </asp:HyperLink>
                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Product.aspx" CssClass="sidebar-link">
                            <span class="nav-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="m12 3 8 4.5v9L12 21l-8-4.5v-9L12 3Z"/><path d="m4.5 7.8 7.5 4.3 7.5-4.3M12 12v9"/></svg></span>
                            Add product
                        </asp:HyperLink>
                        <a href="Feedback.aspx" class="sidebar-link">
                            <span class="nav-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v10Z"/></svg></span>
                            Feedback
                        </a>
                    </nav>
                    <div class="sidebar-logout">
                        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Login.aspx" CssClass="sidebar-link">
                            <span class="nav-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M10 5H5v14h5M14 8l4 4-4 4M18 12H9"/></svg></span>
                            Logout
                        </asp:HyperLink>
                    </div>
                </aside>

                <section class="admin-workspace">
                    <header class="workspace-header">
                        <div class="workspace-heading">
                            <button type="button" id="sidebarToggle" class="mobile-sidebar-toggle" aria-label="Open admin navigation" aria-controls="adminSidebar" aria-expanded="false">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M4 7h16M4 12h16M4 17h16"/></svg>
                            </button>
                            <div>
                                <div class="dashboard-eyebrow">Catalogue setup</div>
                                <h1 class="dashboard-title">Add category</h1>
                                <p class="dashboard-subtitle">Create a category before assigning products to it.</p>
                            </div>
                        </div>
                        <asp:HyperLink ID="BackToDashboard" runat="server" NavigateUrl="~/AdminHome.aspx" CssClass="primary-action">
                            <span class="button-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 6l-6 6 6 6"/></svg></span>
                            <span class="action-label">Back to dashboard</span>
                        </asp:HyperLink>
                    </header>

                    <div class="form-layout">
                        <div class="form-card">
                            <h2 class="section-heading" style="margin-bottom: 20px;">
                                <span class="heading-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M3 6h7l2 2h9v11H3V6Z"/><path d="M3 10h18"/></svg></span>
                                Category details
                            </h2>

                            <!-- Category Name -->
                            <div class="form-field">
                                <asp:Label ID="lblCategoryName" runat="server" AssociatedControlID="txtCategoryName" CssClass="field-label" Text="Category Name"></asp:Label>
                                <asp:TextBox ID="txtCategoryName" runat="server" Width="100%" CssClass="field-input" placeholder="e.g. Electronics"></asp:TextBox>
                                <p class="field-hint">Use a short, shopper-friendly name.</p>
                            </div>

                            <!-- Category Photo -->
                            <div class="form-field">
                                <asp:Label ID="lblCategoryPhoto" runat="server" AssociatedControlID="fuCategoryPhoto" CssClass="field-label" Text="Category Photo"></asp:Label>
                                <div class="file-field">
                                    <asp:FileUpload ID="fuCategoryPhoto" runat="server" />
                                    <p class="field-hint">Square images around 600x600 px look best.</p>
                                </div>
                            </div>

                            <!-- Add Category Button -->
                            <div class="form-actions">
                                <asp:Button ID="btnAddCategory" runat="server" Text="ADD CATEGORY" OnClick="btnAddCategory_Click" CssClass="submit-button" UseSubmitBehavior="true" />
                                <asp:HyperLink ID="CancelLink" runat="server" NavigateUrl="~/AdminHome.aspx" CssClass="ghost-link">Cancel</asp:HyperLink>
                            </div>

                            <div>
                                <asp:Label ID="lblMessage" runat="server" Visible="False" CssClass="status-note">Message</asp:Label>
                            </div>
                        </div>

                        <aside class="guide-card">
                            <h3 class="guide-title">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="9"/><path d="M12 8h.01M11 12h1v4h1"/></svg>
                                Before you save
                            </h3>
                            <ul class="guide-list">
                                <li>Keep category names unique across the store.</li>
                                <li>Upload a clear image with a plain background.</li>
                                <li>New categories appear on the product form right away.</li>
                            </ul>
                        </aside>
                    </div>

                    <!-- Category list with search + status filter -->
                    <div class="list-card">
                        <div class="list-head">
                            <div>
                                <h2 class="section-heading">
                                    <span class="heading-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M4 6h16M4 12h16M4 18h10"/></svg></span>
                                    All categories
                                </h2>
                                <p class="field-hint" style="margin-top:6px;">Review category photos, update names, or remove a category.</p>
                            </div>
                            <div class="filter-bar">
                                <div class="filter-field">
                                    <asp:Label ID="lblSearch" runat="server" AssociatedControlID="txtSearch" CssClass="filter-label" Text="Search"></asp:Label>
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="filter-input" placeholder="Search by category name"></asp:TextBox>
                                </div>
                                <asp:Button ID="btnSearch" runat="server" Text="APPLY" CssClass="filter-button" OnClick="btnSearch_Click" />
                                <asp:Button ID="btnClearFilters" runat="server" Text="Clear" CssClass="filter-reset" OnClick="btnClearFilters_Click" />
                            </div>
                        </div>

                        <div class="table-scroll">
                            <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="false" DataKeyNames="category id"
                                CssClass="data-table" GridLines="None" CellPadding="-1" BorderWidth="0"
                                OnRowEditing="gvCategories_RowEditing"
                                OnRowCancelingEdit="gvCategories_RowCancelingEdit"
                                OnRowUpdating="gvCategories_RowUpdating"
                                OnRowDeleting="gvCategories_RowDeleting">
                                <Columns>
                                    <asp:TemplateField HeaderText="Photo">
                                        <ItemTemplate>
                                            <asp:Image ID="imgCategory" runat="server" CssClass="thumb" AlternateText="Category photo"
                                                ImageUrl='<%# CategoryPhotoUrl(Eval("image")) %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Image ID="imgCategoryEdit" runat="server" CssClass="thumb" AlternateText="Category photo"
                                                ImageUrl='<%# CategoryPhotoUrl(Eval("image")) %>' />
                                            <div style="margin-top:8px;">
                                                <asp:FileUpload ID="fuEditPhoto" runat="server" />
                                            </div>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Category name">
                                        <ItemTemplate>
                                            <span style="font-weight:600;"><%# Eval("categoryname") %></span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtEditName" runat="server" CssClass="filter-input" Text='<%# Bind("categoryname") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <span class="row-actions">
                                                <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" CssClass="row-action is-edit" Text="Edit" />
                                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="row-action is-delete" Text="Delete"
                                                    OnClientClick="return confirm('Delete this category? This cannot be undone.');" />
                                            </span>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <span class="row-actions">
                                                <asp:LinkButton ID="lnkUpdate" runat="server" CommandName="Update" CssClass="row-action is-save" Text="Save" />
                                                <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel" CssClass="row-action is-cancel" Text="Cancel" CausesValidation="false" />
                                            </span>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="empty-state">No categories match your search yet.</div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>

                        <div style="padding: 4px 0 16px;">
                            <asp:Label ID="lblListMessage" runat="server" Visible="False" CssClass="status-note"></asp:Label>
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
                <p class="text-[13px]">© 2022 All rights reserved.</p>
            </div>
        </footer>

    </form>

    <script src="./assets/js/jquery-3.6.0.min.js"></script>
    <script src="./assets/js/main.js"></script>
    <script type="text/javascript">
        (function () {
            function setupAdminSidebar() {
                var shell = document.getElementById('adminShell');
                var toggle = document.getElementById('sidebarToggle');
                var backdrop = document.getElementById('sidebarBackdrop');
                if (!shell || !toggle || !backdrop) return;

                function setOpen(open) {
                    shell.classList.toggle('sidebar-open', open);
                    toggle.setAttribute('aria-expanded', open ? 'true' : 'false');
                    toggle.setAttribute('aria-label', open ? 'Close admin navigation' : 'Open admin navigation');
                }

                toggle.addEventListener('click', function () {
                    setOpen(!shell.classList.contains('sidebar-open'));
                });
                backdrop.addEventListener('click', function () { setOpen(false); });
                document.addEventListener('keydown', function (event) {
                    if (event.key === 'Escape') setOpen(false);
                });
                window.addEventListener('resize', function () {
                    if (window.innerWidth >= 1024) setOpen(false);
                }, { passive: true });
            }

            document.addEventListener('DOMContentLoaded', setupAdminSidebar);
        }());
    </script>
</body>
</html>

