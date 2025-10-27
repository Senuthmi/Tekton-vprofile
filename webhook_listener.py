from flask import Flask, request
import subprocess

app = Flask(__name__)

@app.route('/webhookgrthtr', methods=['POST'])
def webhook():
    event = request.headers.get('X-GitHub-Event', '')
    data = request.json

    if event == "ping":
        print("✅ GitHub webhook ping received!")
        return 'pong', 200

    elif event == "push" and data and data.get('ref') == 'refs/heads/main':
        print("🚀 Push to main detected! Triggering pipeline...")
        subprocess.run(["kubectl", "apply", "-f", "tasks.yaml"], check=True)
        subprocess.run(["kubectl", "apply", "-f", "pipeline.yaml"], check=True)
        subprocess.run(["kubectl", "create", "-f", "pipelinerunner.yaml"], check=True)
        return 'Pipeline triggered!', 200

    else:
        print("❌ Ignored event or wrong branch.")
        return 'Ignored', 200

# 👇 This is essential
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
