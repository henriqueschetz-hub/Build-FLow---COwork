# 🚀 Setup do Webhook BuildFlow - Monitoramento 24/7

## O que é?

Um **webhook externo** que roda **24/7** em um servidor cloud, fazendo monitoramento automático do BuildFlow e enviando alertas por email quando há cards vencidos ou urgentes.

**Benefícios:**
- ✅ Roda independente do app Cowork estar aberto
- ✅ Funciona todos os dias exatamente às 7h00
- ✅ Envia email automático com alertas
- ✅ Grátis (até 750 horas/mês no Render)

---

## 📋 Pré-requisitos

1. **Conta Gmail** com 2FA ativado (para gerar senha de app)
2. **Conta no Render.com** (grátis)
3. **GitHub** (opcional, mas recomendado)

---

## 🔑 Passo 1: Criar Senha de App Gmail

1. Vá para: https://myaccount.google.com/apppasswords
2. Selecione "Mail" e "Windows Computer"
3. Copie a senha gerada (vai ser algo como: `abcd efgh ijkl mnop`)
4. Guarde essa senha - você vai precisar no Passo 3

---

## 📦 Passo 2: Preparar Arquivos

Você deve ter estes 3 arquivos:

```
📁 buildflow-webhook/
├── buildflow_webhook.py    (script principal)
├── requirements.txt        (dependências Python)
└── render.yaml            (config do Render)
```

Se não tiver, baixe de: `/outputs/` do Cowork

---

## 🌐 Passo 3: Deploy no Render (5 minutos)

### 3.1 Criar conta no Render

1. Vá para: https://render.com
2. Faça login com GitHub ou email
3. Clique em "New +"

### 3.2 Upload dos arquivos

**Opção A - Via Git (Recomendado):**

1. Crie um repositório no GitHub
2. Suba os 3 arquivos
3. No Render, selecione "Web Service" e conecte seu repo GitHub

**Opção B - Upload Manual:**

1. No Render, clique "New +" → "Web Service"
2. Escolha "Public Git Repository"
3. Cole a URL do repositório Git com seus arquivos

### 3.3 Configurar variáveis de ambiente

No Render, vá para "Environment" e adicione:

```
EMAIL_REMETENTE = seu_email@gmail.com
EMAIL_SENHA = senha_de_app_que_voce_gerou
PORT = 5000
```

### 3.4 Configurar comando de start

- **Build Command:** `pip install -r requirements.txt`
- **Start Command:** `python buildflow_webhook.py`

### 3.5 Deploy

Clique "Deploy" e aguarde (leva 2-3 minutos)

---

## ✅ Passo 4: Testar

Após o deploy:

1. Copie a URL do seu serviço no Render (algo como: `https://buildflow-webhook.onrender.com`)

2. Faça uma requisição para testar:
```
curl https://buildflow-webhook.onrender.com/run -X POST
```

3. Verifique o log no Render - você deve ver:
```
✅ Login realizado com sucesso
✅ X cards extraídos
✅ Email de alerta enviado (ou nenhum alerta para enviar)
```

---

## 📧 Como os Alertas Funcionam

**Todos os dias às 7h00:**

1. ✅ Acessa o BuildFlow automaticamente
2. ✅ Extrai dados das 4 esteiras
3. ✅ Verifica prazos dos cards
4. ✅ Se houver alertas:
   - 🔴 Envia email com lista de cards vencidos
   - 🟡 Envia email com lista de cards urgentes (próximos 3 dias)
5. ✅ Se tudo ok, roda silenciosamente

---

## 🔔 Problemas Comuns

### ❌ "Erro de autenticação Gmail"

**Solução:**
- Verifique se ativou 2FA na conta Gmail
- Verifique se a senha de app está correta (com espaços incluídos)
- Tente criar uma nova senha de app

### ❌ "Port already in use"

**Solução:**
- No Render, a porta é gerenciada automaticamente
- Deixe `PORT = 5000` na configuração

### ❌ "Webhook não está rodando"

**Solução:**
- Verifique os logs no Render (aba "Logs")
- Teste manualmente via `/run` endpoint
- Verifique se as variáveis de ambiente estão definidas

---

## 📊 Monitorar Execuções

1. Acesse seu webhook no Render
2. Vá para aba "Logs"
3. Você verá um log a cada execução às 7h00

Log esperado:
```
2024-06-30 07:00:00 🔄 Iniciando monitoramento...
2024-06-30 07:00:05 ✅ Login realizado com sucesso
2024-06-30 07:00:10 ✅ 15 cards extraídos
2024-06-30 07:00:15 ✅ Planilha salva
2024-06-30 07:00:20 ✅ Email de alerta enviado (2 vencidos, 1 urgente)
2024-06-30 07:00:22 ✅ Monitoramento concluído
```

---

## 🔐 Segurança

**Suas credenciais estão seguras:**
- ✅ Senhas armazenadas como variáveis de ambiente (criptografadas)
- ✅ Não aparecem nos logs
- ✅ Nunca aparecem no código

---

## 📞 Suporte

Se precisar de ajuda:

1. Verifique os logs no Render
2. Teste o endpoint manualmente: `/run`
3. Confirme que as variáveis de ambiente estão definidas

---

## 📱 Dashboard Alternativo (Opcional)

Se quiser visualizar os alertas em um dashboard, você pode:

1. Criar uma planilha Google que recebe os dados via webhook
2. Criar um Slack bot que envia notificações
3. Usar serviço de webhooks como Zapier

---

**Pronto! Seu webhook está rodando 24/7 e enviando alertas automáticos! 🎉**
