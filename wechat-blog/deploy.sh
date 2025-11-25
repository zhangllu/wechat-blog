#!/bin/bash

# 微信公众号博客 - 快速GitHub部署脚本
# 作者: MiniMax Agent
# 日期: 2025-11-25

echo "🚀 开始部署到GitHub Pages..."
echo "=================================="

# 检查Git是否安装
if ! command -v git &> /dev/null; then
    echo "❌ Git未安装，请先安装Git"
    echo "   Windows: https://git-scm.com/download/win"
    echo "   macOS: brew install git"
    echo "   Linux: sudo apt install git"
    exit 1
fi

# 检查是否在git仓库中
if [ ! -d ".git" ]; then
    echo "📁 初始化Git仓库..."
    git init
    
    echo "📋 请设置Git用户信息（只需设置一次）:"
    read -p "您的GitHub用户名: " github_username
    read -p "您的邮箱: " email
    
    git config user.name "$github_username"
    git config user.email "$email"
fi

# 检查GitHub仓库URL
echo ""
echo "🔗 配置GitHub仓库:"

# 尝试从远程获取仓库URL
remote_url=$(git remote get-url origin 2>/dev/null)

if [ -z "$remote_url" ]; then
    echo "请输入您的GitHub仓库URL，格式如:"
    echo "  https://github.com/您的用户名/仓库名.git"
    echo "或"
    echo "  git@github.com:您的用户名/仓库名.git"
    echo ""
    read -p "仓库URL: " remote_url
    
    if [ -n "$remote_url" ]; then
        git remote add origin "$remote_url"
        echo "✅ 已添加远程仓库"
    else
        echo "⚠️  未设置远程仓库，请稍后手动添加"
    fi
else
    echo "📡 远程仓库: $remote_url"
fi

# 添加所有文件到git
echo ""
echo "📂 添加文件到Git..."
git add .

# 提交更改
echo ""
echo "💾 提交更改..."
read -p "提交信息 (默认: 'Update WeChat blog website'): " commit_message

if [ -z "$commit_message" ]; then
    commit_message="Update WeChat blog website"
fi

git commit -m "$commit_message"

# 推送到GitHub
echo ""
echo "📤 推送到GitHub..."

# 检查是否有远程仓库
if [ -n "$remote_url" ]; then
    # 检查主分支名称
    main_branch="main"
    if git show-ref --verify --quiet refs/heads/master; then
        main_branch="master"
    fi
    
    echo "推送到 $main_branch 分支..."
    
    # 尝试推送
    if git push -u origin $main_branch; then
        echo "✅ 推送成功！"
        echo ""
        echo "🎉 部署步骤:"
        echo "1. 登录 GitHub: https://github.com"
        echo "2. 进入您的仓库"
        echo "3. 点击 Settings > Pages"
        echo "4. Source选择 'Deploy from a branch'"
        echo "5. Branch选择 '$main_branch'"
        echo "6. Folder选择 '/ (root)'"
        echo "7. 点击 Save"
        echo ""
        echo "⏰ 等待几分钟后，您的网站将可以通过以下地址访问:"
        
        # 提取用户名和仓库名
        if [[ $remote_url == *"github.com"* ]]; then
            repo_path=$(echo "$remote_url" | sed -n 's#.*github\.com[:/]\([^/]*\)/\([^/]*\)\.git#\1/\2#p')
            if [ -n "$repo_path" ]; then
                echo "https://github.com/$repo_path"
                username=$(echo "$repo_path" | cut -d'/' -f1)
                reponame=$(echo "$repo_path" | cut -d'/' -f2)
                echo "https://$username.github.io/$reponame/"
            fi
        fi
        
    else
        echo "❌ 推送失败，可能的原因:"
        echo "1. 仓库不存在于GitHub上"
        echo "2. 没有推送权限"
        echo "3. 网络连接问题"
        echo ""
        echo "💡 解决方案:"
        echo "1. 确保已在GitHub上创建仓库"
        echo "2. 检查网络连接"
        echo "3. 手动推送: git push -u origin $main_branch"
    fi
else
    echo "⚠️  未设置远程仓库，请手动推送到GitHub:"
    echo ""
    echo "1. 在GitHub上创建仓库"
    echo "2. 运行以下命令:"
    echo "   git remote add origin https://github.com/您的用户名/仓库名.git"
    echo "   git push -u origin main"
fi

echo ""
echo "🎯 下一步:"
echo "- 启用GitHub Pages (Settings > Pages)"
echo "- 配置自定义域名 (可选)"
echo "- 查看部署状态"
echo ""
echo "📚 详细指南请查看: GitHub_Pages_部署指南.md"
echo ""
echo "部署完成! 🎊"