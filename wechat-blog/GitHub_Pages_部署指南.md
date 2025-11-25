# GitHub Pages 部署指南

## 🚀 快速部署到GitHub Pages

### 第一步：创建GitHub仓库

1. **登录GitHub**
   - 访问 [github.com](https://github.com)
   - 确保已登录您的账户

2. **创建新仓库**
   - 点击右上角的 "+" 号
   - 选择 "New repository"
   - 仓库名称建议：`wechat-blog` 或 `my-wechat-articles`
   - 设置为 Public（GitHub Pages免费版要求）
   - 勾选 "Add a README file"
   - 点击 "Create repository"

### 第二步：上传网站文件

**方法一：GitHub网页界面（推荐新手）**

1. **上传文件**
   - 在仓库页面点击 "uploading an existing file"
   - 将 `wechat-blog` 目录中的所有文件拖拽到上传区域
   - 或者点击 "choose your files" 选择文件

2. **逐个上传核心文件**
   - 先上传 `index.html`
   - 再上传 `assets/` 整个文件夹
   - 最后上传 `posts/` 整个文件夹
   - 以及 `README.md` 等其他文件

**方法二：Git命令行（推荐高级用户）**

```bash
# 1. 克隆仓库
git clone https://github.com/您的用户名/wechat-blog.git
cd wechat-blog

# 2. 复制网站文件
# 将您的 wechat-blog 目录中的所有文件复制到这里

# 3. 提交并推送
git add .
git commit -m "Initial commit: Add WeChat blog website"
git push origin main
```

### 第三步：启用GitHub Pages

1. **进入设置**
   - 在仓库页面点击 "Settings" 标签

2. **配置Pages**
   - 在左侧菜单找到 "Pages"
   - Source 选择 "Deploy from a branch"
   - Branch 选择 "main" （或 "master"）
   - Folder 选择 "/ (root)"
   - 点击 "Save"

3. **等待部署**
   - 几分钟后，GitHub会显示您的网站地址
   - 格式：`https://您的用户名.github.io/wechat-blog`

### 第四步：访问您的网站

部署成功后，您可以通过以下地址访问：

- **主域名**: `https://您的用户名.github.io/wechat-blog`
- **自定义域名**: 如果配置了自定义域名，使用您的域名

## 🔧 自定义域名设置（可选）

### 配置自定义域名

1. **在GitHub仓库中**
   - 进入 Settings > Pages
   - 在 "Custom domain" 中输入您的域名
   - 例如：`blog.yourdomain.com`

2. **DNS配置**
   - 登录您的域名注册商控制台
   - 添加CNAME记录：
     ```
     类型: CNAME
     名称: blog（或您想要的子域名）
     值: 您的用户名.github.io
     ```

3. **SSL证书**
   - 勾选 "Enforce HTTPS"
   - GitHub会自动为您的自定义域名配置SSL证书

## 📝 日常更新网站内容

### 添加新文章

1. **上传文章文件**
   - 将新的Markdown文件上传到 `posts/` 目录
   - 确保文件名格式：`article_XX_文件名.md`

2. **上传相关图片**
   - 将新文章的配图上传到 `assets/images/` 目录
   - 使用有意义的文件名

3. **更新文章列表**
   - 编辑 `assets/js/main.js`
   - 在 `articles` 数组中添加新的文件名

### 修改网站内容

1. **修改主页内容**
   - 编辑 `index.html`

2. **修改样式**
   - 编辑 `assets/css/style.css`

3. **修改功能**
   - 编辑 `assets/js/main.js`

4. **提交更改**
   ```bash
   git add .
   git commit -m "Update: 添加新文章"
   git push origin main
   ```

## 🛠️ 高级配置

### GitHub Actions 自动部署（可选）

创建 `.github/workflows/deploy.yml`：

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
    
    - name: Install dependencies
      run: npm install
    
    - name: Build
      run: npm run build
    
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./
```

### 性能优化

1. **启用压缩**
   - GitHub Pages默认启用Gzip压缩

2. **图片优化**
   - 上传前压缩图片大小
   - 使用WebP格式（如果浏览器支持）

3. **缓存策略**
   - GitHub Pages会自动设置适当的缓存头

## 🔍 故障排除

### 常见问题

1. **网站不显示**
   - 检查GitHub Pages设置是否正确
   - 等待几分钟让部署完成
   - 确认分支名称正确（main vs master）

2. **图片不显示**
   - 检查图片文件路径是否正确
   - 确认文件已正确上传到仓库

3. **搜索功能不工作**
   - 检查 `assets/js/main.js` 是否正确上传
   - 确认浏览器支持JavaScript

4. **自定义域名不工作**
   - 检查DNS配置是否正确
   - 确认CNAME记录设置
   - 等待DNS传播（最多24小时）

### 调试工具

1. **GitHub Pages状态检查**
   - 访问：`https://www.githubstatus.com/`

2. **浏览器开发者工具**
   - 按F12打开开发者工具
   - 检查Console是否有错误信息

3. **网络请求检查**
   - 在Network标签中检查文件加载状态

## 📊 监控和分析

### GitHub Pages 统计

1. **仓库设置中查看**
   - Settings > Pages > Visit site 查看访问次数

2. **Google Analytics（可选）**
   - 在 `index.html` 中添加分析代码
   - 跟踪网站访问和用户行为

### SEO优化

1. **添加sitemap.xml**
   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
     <url>
       <loc>https://您的用户名.github.io/wechat-blog/</loc>
       <lastmod>2025-11-25</lastmod>
       <changefreq>weekly</changefreq>
       <priority>1.0</priority>
     </url>
   </urlset>
   ```

2. **添加robots.txt**
   ```
   User-agent: *
   Allow: /
   
   Sitemap: https://您的用户名.github.io/wechat-blog/sitemap.xml
   ```

## 🎯 最佳实践

1. **定期备份**
   - 定期下载仓库备份
   - 保存原始Markdown文件

2. **版本控制**
   - 使用有意义的提交信息
   - 为重要更改创建标签

3. **安全设置**
   - 启用分支保护
   - 设置访问权限
   - 定期更新依赖

4. **性能监控**
   - 使用Google PageSpeed Insights检查性能
   - 监控网站加载时间
   - 优化图片和资源大小

---

## 🎉 完成！

恭喜！您的微信公众号文章网站现在已成功部署到GitHub Pages，享受免费、可靠、高性能的静态网站托管服务！

**您的网站地址**: `https://您的用户名.github.io/wechat-blog`

如需技术支持，请随时联系！