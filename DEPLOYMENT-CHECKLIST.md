# 📋 部署檢查清單

在部署應用之前，請確認以下所有項目都已完成：

## ✅ Supabase 設置

- [ ] 已創建 Supabase 專案
- [ ] 已在 SQL Editor 執行 `supabase-setup.sql`
- [ ] 已在 Database > Replication 啟用 `rooms` 表的 Realtime
- [ ] 已取得 Project URL
- [ ] 已取得 anon public key
- [ ] 已取得 service_role key（用於 GitHub Actions）

## ✅ 應用配置

- [ ] 已在 `index.html` 中更新 `SUPABASE_URL`
- [ ] 已在 `index.html` 中更新 `SUPABASE_ANON_KEY`
- [ ] 已使用 `test-connection.html` 測試連接（所有測試通過）

## ✅ 功能測試

- [ ] 可以創建房間
- [ ] 可以加入房間
- [ ] 可以添加成員
- [ ] 可以新增支出
- [ ] 可以刪除支出
- [ ] 可以刪除成員
- [ ] 可以查看結算報告
- [ ] 可以分享結算內容
- [ ] 深色/淺色模式切換正常
- [ ] 多個瀏覽器視窗可以即時同步

## ✅ 部署準備

### 選項 A: Vercel
- [ ] 已安裝 Vercel CLI (`npm i -g vercel`)
- [ ] 已執行 `vercel` 命令
- [ ] 部署成功並取得 URL

### 選項 B: GitHub Pages
- [ ] 已初始化 Git (`git init`)
- [ ] 已推送到 GitHub
- [ ] 已在 Settings > Pages 啟用 GitHub Pages
- [ ] 已確認網站可以訪問

### 選項 C: Netlify
- [ ] 已上傳專案到 Netlify
- [ ] 部署成功並取得 URL

## ✅ GitHub Actions（可選但推薦）

- [ ] 已推送專案到 GitHub
- [ ] 已在 Settings > Secrets 添加 `SUPABASE_URL`
- [ ] 已在 Settings > Secrets 添加 `SUPABASE_ANON_KEY`
- [ ] 已在 Settings > Secrets 添加 `SUPABASE_SERVICE_KEY`
- [ ] 已手動觸發 Action 測試（Actions > Keep Supabase Active > Run workflow）
- [ ] Action 執行成功（綠色 ✅）

## ✅ 最終檢查

- [ ] 部署後的網站可以正常訪問
- [ ] 在手機上測試過（響應式設計）
- [ ] 在不同瀏覽器測試過（Chrome, Safari, Firefox）
- [ ] 已分享網址給朋友測試多人協作
- [ ] 已記錄部署的 URL

## 📝 部署資訊記錄

完成部署後，請記錄以下資訊：

```
應用 URL: _________________________________

Supabase 專案名稱: _______________________

部署平台: ☐ Vercel  ☐ GitHub Pages  ☐ Netlify  ☐ 其他

GitHub Actions: ☐ 已啟用  ☐ 未啟用

部署日期: _________________________________

備註: 
_____________________________________________
_____________________________________________
_____________________________________________
```

## 🎉 完成！

恭喜！您的 SplitWise Pro 已成功部署。

### 下一步

1. **分享給朋友**：將部署的 URL 分享給朋友試用
2. **收集反饋**：記錄使用者的意見和建議
3. **持續改進**：根據反饋優化功能

### 維護建議

- **每週檢查**：確認 GitHub Actions 正常運行
- **每月檢查**：查看 Supabase 使用量（Dashboard > Settings > Usage）
- **備份資料**：定期在 Supabase 匯出資料備份

### 需要幫助？

- 查看 `README.md` 了解完整文檔
- 查看 `QUICKSTART.md` 快速開始指南
- 查看 `CONFIG.md` 配置說明
- 在 GitHub 提出 Issue

---

**提示**：將此檢查清單列印出來，逐項勾選，確保不遺漏任何步驟！
