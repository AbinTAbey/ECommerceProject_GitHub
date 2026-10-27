<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="ECommerceproject.Feedback" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="./assets/css/output.css" rel="stylesheet">
    <link href="./assets/css/custom.css" rel="stylesheet" />
    <link href="./assets/css/owlcarousel/owl.carousel.min.css" rel="stylesheet">
    <link href="./assets/css/owlcarousel/owl.theme.default.min.css" rel="stylesheet">
    <title>FlipShop Admin · Customer Feedback</title>
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
        /* ---------- Feedback page ---------- */
        :root {
            --st-new: #2f6fd6; --st-new-soft: rgba(47,111,214,.1);
            --st-viewed: #b7791f; --st-viewed-soft: rgba(183,121,31,.12);
            --st-ok: #23885a; --st-ok-soft: rgba(35,136,90,.11);
            --st-bad: #c93a3a; --st-bad-soft: rgba(214,69,69,.1);
            --st-pending: #6b7d7a; --st-pending-soft: rgba(91,116,112,.12);
        }
        .fb-stats { display: grid; grid-template-columns: repeat(3, minmax(0,1fr)); gap: 14px; margin-bottom: 30px; }
        .fb-stat { position: relative; overflow: hidden; display: flex; align-items: center; gap: 14px; padding: 18px 19px; border: 1px solid var(--admin-line); border-radius: 10px; background: var(--admin-surface); }
        .fb-stat::before { content: ""; position: absolute; left: 0; top: 0; bottom: 0; width: 4px; background: var(--accent); }
        .fb-stat .summary-icon { color: var(--accent); background: var(--accent-soft); }
        .fb-stat.is-new { --accent: var(--st-new); --accent-soft: var(--st-new-soft); }
        .fb-stat.is-viewed { --accent: var(--st-viewed); --accent-soft: var(--st-viewed-soft); }
        .fb-stat.is-resolved { --accent: var(--st-ok); --accent-soft: var(--st-ok-soft); }
        .fb-stat-label { margin: 0; color: var(--admin-muted); font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: .06em; }
        .fb-stat-count { margin: 2px 0 0; font-family: "Space Grotesk", Arial, sans-serif; font-size: 28px; font-weight: 700; line-height: 1.1; }
        .fb-stat-note { margin: 2px 0 0; color: var(--admin-muted); font-size: 11px; }

        .fb-toolbar { display: flex; flex-wrap: wrap; align-items: center; justify-content: space-between; gap: 12px; margin-bottom: 14px; }
        .fb-search { display: flex; align-items: center; gap: 9px; flex: 1 1 260px; max-width: 380px; min-height: 42px; padding: 0 12px; border: 1px solid var(--admin-line); border-radius: 8px; background: var(--admin-surface); color: var(--admin-muted); }
        .fb-search:focus-within { border-color: rgba(15,138,131,.55); box-shadow: 0 0 0 3px rgba(15,138,131,.12); }
        .fb-search svg { width: 17px; height: 17px; flex: 0 0 17px; }
        .fb-search input { width: 100%; border: 0; outline: 0; background: transparent; color: var(--admin-ink); font-size: 13px; }
        .fb-tabs { display: inline-flex; gap: 4px; padding: 4px; border: 1px solid var(--admin-line); border-radius: 9px; background: #f2f9f8; }
        .fb-tab { min-height: 32px; padding: 0 13px; border: 0; border-radius: 6px; background: transparent; color: var(--admin-muted); font-size: 12px; font-weight: 700; cursor: pointer; }
        .fb-tab:hover { color: var(--admin-ink); }
        .fb-tab.is-active { background: var(--admin-surface); color: var(--admin-primary); box-shadow: 0 1px 3px rgba(20,94,99,.14); }
        .fb-tab:focus-visible, .fb-btn:focus-visible, .fb-link:focus-visible { outline: 3px solid rgba(15,138,131,.28); outline-offset: 2px; }

        .badge { display: inline-flex; align-items: center; gap: 6px; min-height: 24px; padding: 0 9px; border-radius: 999px; font-size: 11px; font-weight: 700; white-space: nowrap; }
        .badge::before { content: ""; width: 6px; height: 6px; border-radius: 50%; background: currentColor; }
        .badge-new { color: var(--st-new); background: var(--st-new-soft); }
        .badge-viewed { color: var(--st-viewed); background: var(--st-viewed-soft); }
        .badge-resolved, .badge-sent { color: var(--st-ok); background: var(--st-ok-soft); }
        .badge-failed { color: var(--st-bad); background: var(--st-bad-soft); }
        .badge-pending { color: var(--st-pending); background: var(--st-pending-soft); }
        .badge-sample { color: var(--st-viewed); background: var(--st-viewed-soft); border: 1px dashed rgba(183,121,31,.45); }
        .badge-sample::before { display: none; }

        .fb-empty { padding: 54px 20px; text-align: center; }
        .fb-empty-icon { display: grid; width: 56px; height: 56px; margin: 0 auto 14px; place-items: center; border-radius: 14px; color: var(--admin-primary); background: var(--admin-soft); }
        .fb-empty-icon svg { width: 26px; height: 26px; }
        .fb-empty h3 { margin: 0; font-family: "Space Grotesk", Arial, sans-serif; font-size: 17px; }
        .fb-empty p { max-width: 360px; margin: 6px auto 0; color: var(--admin-muted); font-size: 13px; line-height: 1.5; }
        .fb-preview-toggle { display: inline-flex; align-items: center; gap: 8px; color: var(--admin-muted); font-size: 12px; font-weight: 600; cursor: pointer; }
        .fb-preview-toggle input { width: 15px; height: 15px; accent-color: var(--admin-primary); }
        .fb-id { font-family: "Space Grotesk", Arial, sans-serif; font-weight: 700; color: var(--admin-ink); }
        .fb-cust strong { display: block; color: var(--admin-ink); }
        .fb-cust span { color: var(--admin-muted); font-size: 12px; }
        .fb-link { display: inline-flex; align-items: center; min-height: 32px; padding: 0 11px; border: 1px solid rgba(15,138,131,.35); border-radius: 7px; background: var(--admin-soft); color: var(--admin-primary); font-size: 12px; font-weight: 700; cursor: pointer; }
        .fb-link:hover { background: rgba(15,138,131,.16); }
        .fb-noresult td { padding: 30px 18px !important; color: var(--admin-muted); text-align: center; }

        .fb-btn { display: inline-flex; align-items: center; justify-content: center; gap: 8px; min-height: 40px; padding: 0 15px; border-radius: 8px; font-size: 13px; font-weight: 700; cursor: pointer; border: 1px solid var(--admin-line); background: var(--admin-surface); color: var(--admin-ink); transition: background-color .18s ease, border-color .18s ease; }
        .fb-btn svg { width: 17px; height: 17px; }
        .fb-btn:hover { border-color: rgba(15,138,131,.45); }
        .fb-btn-primary { color: #fff; border-color: rgba(15,138,131,.5); background: var(--admin-primary); box-shadow: 0 8px 18px rgba(15,138,131,.22); }
        .fb-btn-primary:hover { background: var(--admin-primary-dark); }
        .fb-btn-viewed { color: var(--st-viewed); border-color: rgba(183,121,31,.35); background: var(--st-viewed-soft); }
        .fb-btn-ok { color: var(--st-ok); border-color: rgba(35,136,90,.35); background: var(--st-ok-soft); }
        .fb-btn-ok.solid { color: #fff; background: var(--st-ok); }

        .fb-detail[hidden], .fb-list[hidden], .fb-table tr[hidden] { display: none !important; }
        .fb-back { margin-bottom: 18px; }
        .fb-detail-grid { display: grid; grid-template-columns: minmax(0, 1.5fr) minmax(0, 1fr); gap: 18px; align-items: start; }
        .fb-card { padding: 20px; border: 1px solid var(--admin-line); border-radius: 12px; background: var(--admin-surface); }
        .fb-card + .fb-card { margin-top: 18px; }
        .fb-card-title { display: flex; align-items: center; justify-content: space-between; gap: 10px; margin: 0 0 14px; font-family: "Space Grotesk", Arial, sans-serif; font-size: 16px; font-weight: 700; }
        .fb-meta { display: grid; gap: 12px; margin: 0; }
        .fb-meta div { display: grid; gap: 2px; }
        .fb-meta dt { color: var(--admin-muted); font-size: 11px; font-weight: 700; letter-spacing: .07em; text-transform: uppercase; }
        .fb-meta dd { margin: 0; font-size: 14px; font-weight: 600; word-break: break-word; }
        .fb-message { margin: 0; padding: 16px 18px; border-left: 3px solid var(--admin-primary); border-radius: 8px; background: #f2f9f8; color: #2c4547; font-size: 14px; line-height: 1.65; white-space: pre-wrap; }
        .fb-textarea { width: 100%; min-height: 130px; padding: 12px 14px; resize: vertical; border: 1px solid var(--admin-line); border-radius: 9px; color: var(--admin-ink); font: inherit; font-size: 14px; line-height: 1.55; outline: 0; }
        .fb-textarea:focus { border-color: rgba(15,138,131,.55); box-shadow: 0 0 0 3px rgba(15,138,131,.12); }
        .fb-compose-foot { display: flex; flex-wrap: wrap; align-items: center; justify-content: space-between; gap: 12px; margin-top: 10px; }
        .fb-help { margin: 0; color: var(--admin-muted); font-size: 12px; line-height: 1.45; max-width: 340px; }
        .fb-count { color: var(--admin-muted); font-size: 12px; font-variant-numeric: tabular-nums; }
        .fb-note { margin: 12px 0 0; padding: 10px 12px; border-radius: 8px; font-size: 12.5px; font-weight: 600; color: var(--st-viewed); background: var(--st-viewed-soft); }
        .fb-note[hidden] { display: none; }
        .fb-history-toggle { display: inline-flex; align-items: center; gap: 6px; border: 0; background: transparent; color: var(--admin-primary); font-size: 12px; font-weight: 700; cursor: pointer; }
        .fb-history-toggle svg { width: 15px; height: 15px; transition: transform .18s ease; }
        .fb-history-toggle[aria-expanded="false"] svg { transform: rotate(-90deg); }
        .fb-replies { display: grid; gap: 12px; }
        .fb-replies[hidden] { display: none; }
        .fb-reply { padding: 14px 16px; border: 1px solid var(--admin-line); border-radius: 10px; background: #fbfdfd; }
        .fb-reply-head { display: flex; flex-wrap: wrap; align-items: center; justify-content: space-between; gap: 8px; margin-bottom: 7px; }
        .fb-reply-head strong { font-size: 13px; }
        .fb-reply-head span.time { color: var(--admin-muted); font-size: 12px; }
        .fb-reply p { margin: 0; color: #2c4547; font-size: 13.5px; line-height: 1.55; }
        .fb-history-empty { padding: 22px; border: 1px dashed var(--admin-line); border-radius: 10px; color: var(--admin-muted); font-size: 13px; text-align: center; }
        .fb-actions { display: grid; gap: 10px; }
        .fb-confirm { padding: 12px; border: 1px solid rgba(35,136,90,.3); border-radius: 9px; background: var(--st-ok-soft); }
        .fb-confirm[hidden] { display: none; }
        .fb-confirm p { margin: 0 0 10px; font-size: 13px; font-weight: 600; color: #1e5f41; }
        .fb-confirm .row { display: flex; gap: 8px; }

        @media (max-width: 1023px) { .fb-detail-grid { grid-template-columns: 1fr; } }
        @media (max-width: 760px) {
            .fb-stats { grid-template-columns: 1fr; gap: 10px; }
            .fb-search { max-width: none; }
            .fb-tabs { width: 100%; }
            .fb-tab { flex: 1; padding: 0 6px; }
            /* Table rows become stacked cards */
            .fb-table { min-width: 0 !important; }
            .fb-table thead { display: none; }
            .fb-table, .fb-table tbody, .fb-table tr, .fb-table td { display: block; width: 100%; }
            .fb-table tr { padding: 12px 14px; border-bottom: 1px solid var(--admin-line); }
            .fb-table td { display: flex; justify-content: space-between; align-items: center; gap: 12px; padding: 6px 0 !important; border: 0 !important; text-align: right; }
            .fb-table td::before { content: attr(data-label); color: var(--admin-muted); font-size: 10px; font-weight: 700; letter-spacing: .08em; text-transform: uppercase; text-align: left; }
            .fb-table td.fb-empty-cell::before, .fb-noresult td::before { display: none; }
            .fb-table td.fb-empty-cell { display: block; text-align: center; }
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
        <!-- Admin Dashboard Section -->
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
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Category.aspx" CssClass="sidebar-link">
                            <span class="nav-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M3 6h7l2 2h9v11H3V6Z"/><path d="M3 10h18"/></svg></span>
                            Add category
                        </asp:HyperLink>
                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Product.aspx" CssClass="sidebar-link">
                            <span class="nav-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="m12 3 8 4.5v9L12 21l-8-4.5v-9L12 3Z"/><path d="m4.5 7.8 7.5 4.3 7.5-4.3M12 12v9"/></svg></span>
                            Add product
                        </asp:HyperLink>
                        <%-- New Feedback item. To add it to AdminHome / Category / Product, paste this link below "Add product"
                             and remove the is-active class and aria-current there. --%>
                        <a href="Feedback.aspx" class="sidebar-link is-active" aria-current="page">
                            <span class="nav-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v10Z"/></svg></span>
                            Feedback
                        </a>
                    </nav>
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
                                <div class="dashboard-eyebrow">Customer support</div>
                                <h1 class="dashboard-title">Customer Feedback</h1>
                                <p class="dashboard-subtitle">Review customer messages, respond to issues, and track resolution.</p>
                            </div>
                        </div>
                    </header>

                    <!-- ===================== LIST VIEW ===================== -->
                    <div id="fbList" class="fb-list" runat="server" ClientIDMode="Static">
                        <asp:Label ID="litPageError" runat="server" Visible="false" CssClass="fb-note on is-error" />
                        <div class="fb-stats" aria-label="Feedback summary">
                            <div class="fb-stat is-new">
                                <span class="summary-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M4 4h16v12H5.2L4 17.2V4Z"/><path d="M8 9h8M8 12h5"/></svg></span>
                                <div><p class="fb-stat-label">New feedback</p><p class="fb-stat-count"><asp:Literal ID="countNew" runat="server" Text="0" /></p><p class="fb-stat-note">Live feedback</p></div>
                            </div>
                            <div class="fb-stat is-viewed">
                                <span class="summary-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M2 12s3.6-7 10-7 10 7 10 7-3.6 7-10 7S2 12 2 12Z"/><circle cx="12" cy="12" r="3"/></svg></span>
                                <div><p class="fb-stat-label">Viewed</p><p class="fb-stat-count"><asp:Literal ID="countViewed" runat="server" Text="0" /></p><p class="fb-stat-note">Live feedback</p></div>
                            </div>
                            <div class="fb-stat is-resolved">
                                <span class="summary-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="9"/><path d="m8 12 3 3 5-6"/></svg></span>
                                <div><p class="fb-stat-label">Resolved</p><p class="fb-stat-count"><asp:Literal ID="countResolved" runat="server" Text="0" /></p><p class="fb-stat-note">Live feedback</p></div>
                            </div>
                        </div>

                        <section class="products-section" aria-labelledby="fbHeading">
                            <div class="section-header">
                                <h2 id="fbHeading" class="section-heading">
                                    <span class="heading-icon" aria-hidden="true"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v10Z"/></svg></span>
                                    All feedback
                                </h2>
                            </div>

                            <div class="fb-toolbar">
                                <label class="fb-search">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><circle cx="11" cy="11" r="7"/><path d="m20 20-3.5-3.5"/></svg>
                                    <input type="search" id="fbSearch" placeholder="Search by customer or subject..." aria-label="Search feedback" maxlength="100" />
                                </label>
                                <div class="fb-tabs" role="tablist" aria-label="Filter by status">
                                    <button type="button" class="fb-tab is-active" role="tab" aria-selected="true" data-filter="all">All</button>
                                    <button type="button" class="fb-tab" role="tab" aria-selected="false" data-filter="new">New</button>
                                    <button type="button" class="fb-tab" role="tab" aria-selected="false" data-filter="viewed">Viewed</button>
                                    <button type="button" class="fb-tab" role="tab" aria-selected="false" data-filter="resolved">Resolved</button>
                                </div>
                            </div>

                            <div class="product-grid-wrapper">
                                <table class="product-grid fb-table">
                                    <thead>
                                        <tr><th>Feedback ID</th><th>Customer</th><th>Subject</th><th>Submitted</th><th>Email status</th><th>Feedback status</th><th>Actions</th></tr>
                                    </thead>
                                    <tbody id="fbRows">
                                        <asp:Repeater ID="rptFeedback" runat="server" OnItemCommand="rptFeedback_ItemCommand">
                                            <ItemTemplate>
                                                <tr class="fb-row" data-status='<%# SafeStatus(Eval("Status")) %>' data-search='<%# SearchValue(Eval("CustomerName"), Eval("Subject")) %>'>
                                                    <td data-label="Feedback ID"><span class="fb-id"><%#: Eval("FeedbackId") %></span></td>
                                                    <td data-label="Customer" class="fb-cust"><div><strong><%#: Eval("CustomerName") %></strong><span><%#: Eval("CustomerEmail") %></span></div></td>
                                                    <td data-label="Subject"><%#: Eval("Subject") %></td>
                                                    <td data-label="Submitted"><%#: FormatDate(Eval("SubmittedAt")) %></td>
                                                    <td data-label="Email status"><span class='badge badge-<%# SafeEmailStatus(Eval("EmailStatus")) %>'><%#: Eval("EmailStatus") %></span></td>
                                                    <td data-label="Feedback status"><span class='badge badge-<%# SafeStatus(Eval("Status")) %>'><%#: Eval("Status") %></span></td>
                                                    <td data-label="Actions"><asp:LinkButton ID="btnViewFeedback" runat="server" CssClass="fb-link" CommandName="Select" CommandArgument='<%# Eval("FeedbackId") %>' Text="View Details" /></td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                        <tr id="fbEmptyRow">
                                            <td colspan="7" class="fb-empty-cell">
                                                <div class="fb-empty">
                                                    <div class="fb-empty-icon" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2v10Z"/><path d="M8 9h8M8 12h5"/></svg></div>
                                                    <h3>No feedback yet</h3>
                                                    <p>Customer feedback will appear here when someone submits the Contact Us form.</p>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr id="fbNoResult" class="fb-noresult" hidden><td colspan="7">No feedback matches your search or filter.</td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </section>
                    </div>

                    <!-- ===================== DETAIL VIEW ===================== -->
                    <div id="fbDetail" class="fb-detail" runat="server" ClientIDMode="Static" Visible="false">
                        <asp:LinkButton ID="btnBack" runat="server" CssClass="fb-btn fb-back" OnClick="btnBack_Click">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M15 18l-6-6 6-6"/></svg>
                            Back to all feedback
                        </asp:LinkButton>
                        <asp:HiddenField ID="hfFeedbackId" runat="server" />
                        <div class="fb-detail-grid">
                            <div>
                                <div class="fb-card">
                                    <h2 class="fb-card-title">
                                        <span>Feedback <asp:Literal ID="litDetailId" runat="server" /></span>
                                        <asp:Label ID="litDetailStatus" runat="server" />
                                    </h2>
                                    <p id="Customer" class="badge badge-Customer" style="margin:0 0 14px" hidden>Customer feedback</p>
                                    <h3 style="margin:0 0 12px;font-size:15px"><asp:Literal ID="litDetailSubject" runat="server" /></h3>
                                    <p class="fb-message"><asp:Literal ID="litDetailMessage" runat="server" /></p>
                                </div>

                                <div class="fb-card">
                                    <h2 class="fb-card-title"><span>Reply to Customer</span></h2>
                                    <%-- BACKEND HOOK: Send Reply will later post to the server, store the reply and email it. --%>
                                    <label for="txtReply" class="sr-only" style="position:absolute;width:1px;height:1px;overflow:hidden;clip:rect(0,0,0,0)">Reply message</label>
                                    <asp:TextBox ID="txtReply" runat="server" ClientIDMode="Static" CssClass="fb-textarea" MaxLength="2000" TextMode="MultiLine" placeholder="Write your response..."></asp:TextBox>
                                    <div class="fb-compose-foot">
                                        <p class="fb-help">Your reply will be emailed to the customer's registered address. You can send more than one reply.</p>
                                        <div style="display:flex;align-items:center;gap:12px">
                                            <span id="fbCount" class="fb-count">0 / 2000</span>
                                            <asp:LinkButton ID="btnSendReply" runat="server" CssClass="fb-btn fb-btn-primary" OnClick="btnSendReply_Click">
                                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="M22 2 11 13M22 2l-7 20-4-9-9-4 20-7Z"/></svg>
                                                Send Reply
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                    <asp:Label ID="litReplyNotice" runat="server" />
                                </div>

                                <div class="fb-card">
                                    <h2 class="fb-card-title">
                                        <span>Reply History</span>
                                        <button type="button" id="fbHistoryToggle" class="fb-history-toggle" aria-expanded="true" aria-controls="fbReplies">
                                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><path d="m6 9 6 6 6-6"/></svg>
                                            <span>Hide</span>
                                        </button>
                                    </h2>
                                    <div id="fbReplies" class="fb-replies">
                                        <asp:Literal ID="litNoReplies" runat="server" Text="<div class='fb-history-empty'>No replies yet. Replies you send will be listed here.</div>" />
                                        <asp:Repeater ID="rptReplies" runat="server" OnItemCommand="rptReplies_ItemCommand">
                                            <ItemTemplate>
                                                <div class="fb-reply"><div class="fb-reply-head"><strong><%#: Eval("AdminName") %></strong>
                                                    <span style="display:flex;gap:10px;align-items:center"><span class="time"><%#: FormatDate(Eval("RepliedAt")) %></span>
                                                    <span class='badge badge-<%# SafeEmailStatus(Eval("EmailStatus")) %>'><%#: Eval("EmailStatus") %></span></span></div>
                                                    <p><%#: Eval("ReplyMessage") %></p>
                                                    <asp:LinkButton ID="btnRetryReply" runat="server" CssClass="fb-link" Visible='<%# string.Equals(Convert.ToString(Eval("EmailStatus")), "Failed", StringComparison.OrdinalIgnoreCase) %>' CommandName="Retry" CommandArgument='<%# Eval("ReplyId") %>' Text="Retry email" />
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>

                            <aside>
                                <div class="fb-card">
                                    <h2 class="fb-card-title"><span>Customer</span></h2>
                                    <dl class="fb-meta">
                                        <div><dt>Name</dt><dd><asp:Literal ID="litDetailName" runat="server" /></dd></div>
                                        <div><dt>Registered email</dt><dd><asp:Literal ID="litDetailEmail" runat="server" /></dd></div>
                                        <div><dt>Submitted</dt><dd><asp:Literal ID="litDetailDate" runat="server" /></dd></div>
                                        <div><dt>Email status</dt><dd><asp:Label ID="litDetailEmailStatus" runat="server" /></dd></div>
                                    </dl>
                                </div>
                                <div class="fb-card">
                                    <h2 class="fb-card-title"><span>Status</span></h2>
                                    <div class="fb-actions">
                                        <asp:LinkButton ID="btnMarkViewed" runat="server" CssClass="fb-btn fb-btn-viewed" OnClick="btnMarkViewed_Click">
                                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M2 12s3.6-7 10-7 10 7 10 7-3.6 7-10 7S2 12 2 12Z"/><circle cx="12" cy="12" r="3"/></svg>
                                            Mark as Viewed
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnMarkResolved" runat="server" CssClass="fb-btn fb-btn-ok" OnClick="btnMarkResolved_Click" OnClientClick="return confirm('Mark this feedback as resolved?');">
                                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><circle cx="12" cy="12" r="9"/><path d="m8 12 3 3 5-6"/></svg>
                                            Mark as Resolved
                                        </asp:LinkButton>
                                        <div id="fbConfirm" class="fb-confirm" hidden>
                                            <p>Mark this feedback as resolved?</p>
                                            <div class="row">
                                                <button type="button" id="fbConfirmYes" class="fb-btn fb-btn-ok solid">Yes, resolve</button>
                                                <button type="button" id="fbConfirmNo" class="fb-btn">Cancel</button>
                                            </div>
                                        </div>
                                        <p id="fbStatusNote" class="fb-note" role="status" hidden></p>
                                    </div>
                                </div>
                            </aside>
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
    <script type="text/javascript">
        (function () {
            var filter = 'all';
            function applyFilter() {
                var search = document.getElementById('fbSearch');
                var query = search ? search.value.trim().toLowerCase() : '';
                var rows = document.querySelectorAll('#fbRows tr.fb-row');
                var visible = 0;
                rows.forEach(function (row) {
                    var statusMatch = filter === 'all' || row.getAttribute('data-status') === filter;
                    var searchMatch = !query || (row.getAttribute('data-search') || '').indexOf(query) !== -1;
                    row.hidden = !(statusMatch && searchMatch);
                    if (!row.hidden) visible++;
                });
                var empty = document.getElementById('fbEmptyRow');
                var noResult = document.getElementById('fbNoResult');
                if (empty) empty.hidden = rows.length !== 0;
                if (noResult) noResult.hidden = rows.length === 0 || visible !== 0;
            }
            function updateReplyCount() {
                var reply = document.getElementById('txtReply');
                var counter = document.getElementById('fbCount');
                if (reply && counter) counter.textContent = reply.value.length + ' / 2000';
            }
            function initializeReplyCounter() {
                var reply = document.getElementById('txtReply');
                if (!reply) return;
                if (reply.getAttribute('data-counter-listeners') !== 'attached') {
                    reply.setAttribute('data-counter-listeners', 'attached');
                    reply.addEventListener('input', updateReplyCount);
                    reply.addEventListener('change', updateReplyCount);
                    reply.addEventListener('paste', function () { window.setTimeout(updateReplyCount, 0); });
                    reply.addEventListener('cut', function () { window.setTimeout(updateReplyCount, 0); });
                }
                updateReplyCount();
            }
            if (!window.__feedbackReplyCounterLifecycle) {
                window.__feedbackReplyCounterLifecycle = true;
                document.addEventListener('DOMContentLoaded', initializeReplyCounter);
                window.addEventListener('pageshow', initializeReplyCounter);
                if (window.Sys && Sys.WebForms && Sys.WebForms.PageRequestManager) {
                    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(initializeReplyCounter);
                }
            }
            document.addEventListener('DOMContentLoaded', function () {
                var search = document.getElementById('fbSearch');
                if (search) search.addEventListener('input', applyFilter);
                document.querySelectorAll('.fb-tab').forEach(function (tab) {
                    tab.addEventListener('click', function () {
                        document.querySelectorAll('.fb-tab').forEach(function (item) {
                            item.classList.remove('is-active');
                            item.setAttribute('aria-selected', 'false');
                        });
                        tab.classList.add('is-active');
                        tab.setAttribute('aria-selected', 'true');
                        filter = tab.getAttribute('data-filter') || 'all';
                        applyFilter();
                    });
                });
                applyFilter();
                initializeReplyCounter();
            });
        }());    </script>
</body>
</html>

