#!/bin/bash
# AWS EC2 User Data Script for Day 2
# Automatically installs and configures Apache web server

set -e  # Exit on error

echo "🚀 Starting EC2 User Data Script - $(date)"
echo "=========================================="

# Update package lists
echo "📦 Updating package lists..."
apt-get update -y

# Install Apache
echo "🔧 Installing Apache web server..."
apt-get install -y apache2

# Create web directory
echo "📁 Setting up web directory..."
mkdir -p /var/www/html

# Deploy index.html
echo "🌐 Deploying website..."
cat > /var/www/html/index.html << 'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AWS EC2 - Day 2 Deployment</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #333;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .container {
            background: white;
            border-radius: 20px;
            padding: 40px;
            max-width: 800px;
            width: 100%;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            animation: fadeIn 0.5s ease-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h1 { 
            color: #232f3e; 
            margin-bottom: 20px;
            font-size: 2.5em;
            border-bottom: 3px solid #ff9900;
            padding-bottom: 10px;
        }
        .badge {
            display: inline-block;
            background: #ff9900;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            margin-bottom: 20px;
        }
        .feature {
            background: #f7f9fc;
            padding: 20px;
            margin: 15px 0;
            border-radius: 10px;
            border-left: 4px solid #00a1ff;
        }
        .feature h3 {
            color: #00a1ff;
            margin-bottom: 10px;
        }
        .success {
            text-align: center;
            background: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 10px;
            margin: 20px 0;
            font-weight: bold;
        }
        .tech-stack {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin: 20px 0;
        }
        .tech-item {
            background: #e9ecef;
            padding: 8px 15px;
            border-radius: 15px;
            font-size: 0.9em;
        }
        footer {
            margin-top: 30px;
            text-align: center;
            color: #666;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 AWS EC2 Web Server</h1>
        <div class="badge">Day 2 - Automated Deployment</div>
        
        <div class="success">
            ✅ Success! This server was deployed automatically via User Data script.
        </div>
        
        <div class="feature">
            <h3>📊 Deployment Details</h3>
            <p><strong>Instance ID:</strong> <span id="instance-id">Loading...</span></p>
            <p><strong>Availability Zone:</strong> <span id="availability-zone">Loading...</span></p>
            <p><strong>Deployment Time:</strong> <span id="deployment-time">$(date)</span></p>
        </div>
        
        <div class="feature">
            <h3>🔧 Technical Stack</h3>
            <div class="tech-stack">
                <span class="tech-item">Ubuntu 22.04</span>
                <span class="tech-item">Apache 2.4</span>
                <span class="tech-item">t2.micro</span>
                <span class="tech-item">AWS EC2</span>
                <span class="tech-item">Bash Scripting</span>
            </div>
        </div>
        
        <div class="feature">
            <h3>🎯 Learning Objectives Achieved</h3>
            <ul>
                <li>EC2 instance creation and configuration</li>
                <li>Security group setup (SSH + HTTP)</li>
                <li>User Data automation scripts</li>
                <li>Apache web server installation</li>
                <li>Static website deployment</li>
                <li>SSH key pair management</li>
            </ul>
        </div>
        
        <footer>
            <p>Part of the AWS 7-Day Learning Challenge</p>
            <p>GitHub: <a href="https://github.com/burgoju" target="_blank">@burgoju</a></p>
        </footer>
    </div>
    
    <script>
        // Fetch AWS instance metadata
        async function fetchMetadata() {
            try {
                const instanceId = await fetch('http://169.254.169.254/latest/meta-data/instance-id').then(r => r.text());
                const az = await fetch('http://169.254.169.254/latest/meta-data/placement/availability-zone').then(r => r.text());
                
                document.getElementById('instance-id').textContent = instanceId;
                document.getElementById('availability-zone').textContent = az;
            } catch (error) {
                console.log('Running locally, not on EC2');
            }
        }
        
        fetchMetadata();
    </script>
</body>
</html>
HTML

# Set proper permissions
echo "🔐 Setting file permissions..."
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

# Enable and start Apache
echo "⚡ Starting Apache service..."
systemctl enable apache2
systemctl start apache2

# Create deployment log
echo "📝 Creating deployment log..."
cat > /var/www/html/deployment-info.html << 'INFO'
<!DOCTYPE html>
<html>
<head><title>Deployment Info</title></head>
<body>
<h1>Deployment Information</h1>
<p><strong>Deployment Time:</strong> $(date)</p>
<p><strong>Script Version:</strong> 1.0</p>
<p><strong>Status:</strong> ✅ Success</p>
</body>
</html>
INFO

# Test the web server
echo "🔍 Testing web server..."
curl -s http://localhost > /tmp/web-test.html

echo "✅ Deployment completed successfully at $(date)"
echo "🌐 Website should be available at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)"

# Write completion marker
echo "COMPLETED_AT=$(date)" > /tmp/deployment-status.txt
