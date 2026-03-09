# DreamNova Voice — Kol Nova (קול נובה)

Couverture téléphonique intelligente 24/7 pour cliniques & PME.

## Checklist Déploiement

### Comptes Gratuits à Créer

- [ ] **Vapi.ai** → vapi.ai → Sign up → ~1,000 min trial
- [ ] **Make.com** → make.com → Sign up → 1,000 ops/mois gratuit
- [ ] **Google Calendar** → Utiliser le Google Calendar existant du client
- [ ] **Loom** → loom.com → Sign up → 25 vidéos, 5 min max (gratuit)
- [ ] **Netlify** → netlify.com → Déployer la landing page (gratuit)

### Fichiers du Projet

| Fichier | Description |
|---------|-------------|
| `index.html` | Landing page Kol Nova (hébreu RTL, Tailwind CSS) |
| `prospect_dentistes.md` | Instructions de qualification + 15 variantes WhatsApp |
| `vapi_config.json` | Configuration agent vocal Vapi (system prompt + tools) |
| `make_blueprint.json` | Blueprint Make.com (Webhook → Google Calendar → Response) |
| `sales_kit.md` | Scripts WA, objections, grille tarifaire, templates factures |
| `README.md` | Ce fichier |

---

## Timeline Jour 1 — Heure par Heure

### 08h-09h : Build Agent Vapi

1. Se connecter à vapi.ai
2. Créer un nouvel assistant
3. Copier le system prompt de `vapi_config.json`
4. Remplacer les placeholders : `[CLINIC_NAME]`, `[HOURS]`, etc. avec une clinique générique de Jérusalem
5. Configurer la voix (ElevenLabs, voix féminine hébreu)
6. Ajouter le tool `book_appointment`
7. Tester l'agent avec le téléphone intégré Vapi

### 09h-09h30 : Créer le Loom

1. Ouvrir Loom + split screen
2. Côté gauche : téléphone/Vapi qui sonne
3. Côté droit : Google Calendar ouvert
4. Appeler l'agent, avoir une conversation naturelle
5. Montrer le RDV qui apparaît dans le calendrier
6. 60 secondes max. Script dans `sales_kit.md`

### 09h30-10h30 : Qualifier 10 Cliniques

1. Google Maps → "מרפאת שיניים ירושלים"
2. Suivre les critères de `prospect_dentistes.md`
3. Remplir le CSV avec 10 leads HOT
4. Pour chaque : noter l'avis clé à mentionner dans le WhatsApp

### 10h30-12h : Envoyer 10 WhatsApp

1. Personnaliser la variante WhatsApp pour chaque lead
2. Mentionner un avis spécifique quand possible
3. Inclure le lien Loom
4. Envoyer un par un (pas de broadcast — c'est personnel)

### 12h-13h : Pause — Hok Breslev + Déjeuner

### 13h-15h : Follow-up Téléphonique

1. Rappeler les 10 leads
2. Si intéressé → proposer démo live (appeler l'agent devant eux)
3. Si pas répondu au WA → appeler directement
4. Objectif : 3-5 conversations qualifiées

### 15h-16h : Closer

1. Proposer le pilote 390₪ ou setup complet 2,000₪
2. Utiliser les kill shots de `sales_kit.md`
3. Si close : envoyer la facture (template dans `sales_kit.md`)
4. Encaisser via virement/Bit

### 16h-17h : Déployer Agent Client #1

1. Dupliquer l'agent Vapi
2. Personnaliser : nom clinique, adresse, horaires, traitements
3. Créer le scenario Make.com (suivre `make_blueprint.json`)
4. Connecter le Google Calendar du client
5. Tester end-to-end : appel → RDV dans le calendrier
6. Configurer le transfert d'appel sur le téléphone du client

---

## Instructions Encaissement par Pays

### Israël 🇮🇱
- **Moyen** : Virement bancaire (העברה בנקאית) + Bit pour petits montants
- **Facturation** : Heshbonit (חשבונית) — template dans `sales_kit.md`
- **TVA** : Osek Patur = pas de TVA si CA < 120,000₪/an
- **Monnaie** : ILS (₪)

### France 🇫🇷
- **Moyen** : Wise Business EUR (IBAN européen)
- **Facturation** : Facture standard — TVA auto-liquidée (art. 283-2 CGI)
- **Monnaie** : EUR (€)
- **Note** : NE PAS utiliser Stripe/PayPal au démarrage (risque gel de fonds)

### USA/Canada 🇺🇸🇨🇦
- **Moyen** : Wise Business USD (routing number + account number US)
- **Facturation** : Invoice standard en anglais
- **Monnaie** : USD ($)
- **Note** : Le client fait un virement ACH normal

---

## Déployer la Landing Page

```bash
# Option 1 : Netlify (gratuit)
cd ~/Desktop/_CLIENTS_ACTIFS/DREAMNOVA_VOICE
npx netlify-cli deploy --prod --dir=.

# Option 2 : Vercel
vercel --prod --token=$VERCEL_TOKEN
```

**IMPORTANT** : Remplacer `972XXXXXXXXX` dans index.html par le vrai numéro WhatsApp de David.

---

## Stack Technique (Zéro Budget)

| Outil | Tier | Limite |
|-------|------|--------|
| Vapi.ai | Trial ~1,000 min | Suffisant pour 10+ démos |
| Make.com | Free 1,000 ops/mois | ~500 RDV/mois |
| Google Calendar | Illimité | Tous les clients |
| Loom | Free 25 vidéos | Suffisant pour 20 prospects |
| WhatsApp | Gratuit | Prospection illimitée |
| Netlify | Free | Landing page |

**Règle** : Le client #1 finance l'infra du client #2.

---

## Règles de Sécurité (Non-Négociables)

1. L'agent ne donne **JAMAIS** de conseil médical ni de diagnostic
2. L'agent ne communique **JAMAIS** de prix de traitements
3. L'agent ne fait **JAMAIS** de promesse clinique
4. Urgence = transfert immédiat vers ligne humaine
5. Résumé quotidien envoyé au propriétaire
6. Conservation minimale des données, zéro donnée médicale

---

*Na Na'h Na'hma Na'hman MeUman — Ein Ye'ush Ba'olam Klal*

*DreamNova Consult • Jérusalem • Mars 2026*
