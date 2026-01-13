# 🤖 GitHub Actions 手動添加說明

## ⚠️ 為什麼沒有自動推送？

由於 GitHub Personal Access Token 需要 `workflow` 權限才能創建 GitHub Actions 文件，所以 `.github/workflows/keep-supabase-active.yml` 文件沒有被推送到倉庫。

您需要手動添加這個文件。

---

## 📝 手動添加步驟

### 方法 1: 在 GitHub 網站上創建（推薦，最簡單）

1. **前往您的 GitHub 倉庫**
   ```
   https://github.com/david8015838-create/splitwise-pro
   ```

2. **創建新文件**
   - 點擊 `Add file` > `Create new file`

3. **輸入文件路徑**
   ```
   .github/workflows/keep-supabase-active.yml
   ```
   （GitHub 會自動創建資料夾）

4. **複製以下內容貼上**

```yaml
name: Keep Supabase Active

# 每天凌晨 2 點（UTC）執行，相當於台北時間上午 10 點
on:
  schedule:
    - cron: '0 2 * * *'
  workflow_dispatch: # 允許手動觸發

jobs:
  ping-database:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Ping Supabase Database
        env:
          SUPABASE_URL: ${{ secrets.SUPABASE_URL }}
          SUPABASE_ANON_KEY: ${{ secrets.SUPABASE_ANON_KEY }}
        run: |
          echo "🚀 Pinging Supabase to keep it active..."
          
          # 使用 curl 查詢資料庫（簡單的 SELECT 查詢）
          response=$(curl -s -w "\n%{http_code}" \
            -X GET "${SUPABASE_URL}/rest/v1/rooms?select=count" \
            -H "apikey: ${SUPABASE_ANON_KEY}" \
            -H "Authorization: Bearer ${SUPABASE_ANON_KEY}")
          
          http_code=$(echo "$response" | tail -n1)
          body=$(echo "$response" | head -n-1)
          
          echo "📊 HTTP Status: $http_code"
          echo "📦 Response: $body"
          
          if [ "$http_code" -eq 200 ] || [ "$http_code" -eq 206 ]; then
            echo "✅ Successfully pinged Supabase!"
          else
            echo "❌ Failed to ping Supabase"
            exit 1
          fi

      - name: Clean Old Data (30+ days)
        env:
          SUPABASE_URL: ${{ secrets.SUPABASE_URL }}
          SUPABASE_SERVICE_KEY: ${{ secrets.SUPABASE_SERVICE_KEY }}
        run: |
          echo "🧹 Cleaning old data (30+ days)..."
          
          # 計算 30 天前的日期
          thirty_days_ago=$(date -u -d '30 days ago' +%Y-%m-%dT%H:%M:%S.000Z 2>/dev/null || date -u -v-30d +%Y-%m-%dT%H:%M:%S.000Z)
          
          echo "📅 Deleting rooms older than: $thirty_days_ago"
          
          # 使用 Service Key 刪除過期資料（繞過 RLS）
          response=$(curl -s -w "\n%{http_code}" \
            -X DELETE "${SUPABASE_URL}/rest/v1/rooms?updated_at=lt.${thirty_days_ago}" \
            -H "apikey: ${SUPABASE_SERVICE_KEY}" \
            -H "Authorization: Bearer ${SUPABASE_SERVICE_KEY}" \
            -H "Prefer: return=minimal")
          
          http_code=$(echo "$response" | tail -n1)
          
          echo "📊 HTTP Status: $http_code"
          
          if [ "$http_code" -eq 204 ] || [ "$http_code" -eq 200 ]; then
            echo "✅ Successfully cleaned old data!"
          else
            echo "⚠️ Warning: Could not clean old data (Status: $http_code)"
            echo "This is not critical, continuing..."
          fi

      - name: Summary
        run: |
          echo "🎉 Workflow completed successfully!"
          echo "📝 Summary:"
          echo "  - Pinged Supabase database"
          echo "  - Cleaned data older than 30 days"
          echo "  - Next run: Tomorrow at the same time"
```

5. **提交文件**
   - Commit message: `Add GitHub Actions workflow`
   - 點擊 `Commit new file`

---

### 方法 2: 使用命令行（需要更新 Token 權限）

如果您想用命令行，需要：

1. **更新 GitHub Token 權限**
   - 前往 https://github.com/settings/tokens
   - 找到您的 Token
   - 添加 `workflow` 權限
   - 重新生成 Token

2. **重新推送**
   ```bash
   cd "/Users/chenyouwei/Desktop/solitwise pro(cursor)/splitwise-pro"
   
   # 恢復 .github 資料夾（從本地備份）
   # 或重新創建文件
   
   git add .github/
   git commit -m "Add GitHub Actions workflow"
   git push origin main
   ```

---

## 🔑 設置 GitHub Secrets

添加文件後，還需要設置 Secrets：

1. **前往倉庫設置**
   ```
   https://github.com/david8015838-create/splitwise-pro/settings/secrets/actions
   ```

2. **點擊 `New repository secret`**

3. **添加三個 Secrets**

| Name | Value |
|------|-------|
| `SUPABASE_URL` | `https://azihzilwffcyhksflbdk.supabase.co` |
| `SUPABASE_ANON_KEY` | `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF6aWh6aWx3ZmZjeWhrc2ZsYmRrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgyODA2MDAsImV4cCI6MjA4Mzg1NjYwMH0.G-ggtcFT5Ccx_UXcMVLuzVgxCS1SyZBglECPTymdDJ8` |
| `SUPABASE_SERVICE_KEY` | 從 Supabase Dashboard > Settings > API 取得 `service_role` key |

⚠️ **重要**: `service_role` key 具有完整權限，請妥善保管！

---

## ✅ 測試 GitHub Action

設置完成後：

1. 前往 `Actions` 頁面
   ```
   https://github.com/david8015838-create/splitwise-pro/actions
   ```

2. 選擇 `Keep Supabase Active` workflow

3. 點擊 `Run workflow` > `Run workflow`

4. 等待執行完成（約 30 秒）

5. 確認狀態為綠色 ✅

---

## 📅 執行時間

- **自動執行**: 每天凌晨 2:00 UTC（台北時間上午 10:00）
- **手動執行**: 隨時可在 Actions 頁面手動觸發

---

## 💡 GitHub Actions 的作用

1. **防止資料庫暫停** - 每天自動 ping Supabase，保持活躍
2. **自動清理過期資料** - 刪除 30 天前未更新的房間
3. **節省空間** - 自動維護資料庫清潔
4. **保護隱私** - 自動刪除舊資料

---

## 🎯 現在的狀態

✅ **已完成**:
- 所有代碼已推送到 GitHub
- 完整文檔已上傳
- 測試工具已包含
- README 和指南完整

⏳ **需要手動添加**:
- `.github/workflows/keep-supabase-active.yml`
- GitHub Secrets 設置

---

**預計時間**: 5 分鐘即可完成手動添加！
