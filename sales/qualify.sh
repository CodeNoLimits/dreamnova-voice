#!/bin/bash
# qualify.sh — Script de qualification rapide pour leads DreamNova Voice
# Usage: bash qualify.sh

CSV_FILE="$(dirname "$0")/../leads.csv"

# Créer le CSV avec headers si inexistant
if [ ! -f "$CSV_FILE" ]; then
  echo "Nom,Téléphone,Site,Note,Nb_Avis,Avis_Clé,Ville,Statut,Date" > "$CSV_FILE"
  echo "📄 Fichier leads.csv créé."
fi

echo ""
echo "═══════════════════════════════════════════"
echo "  🦷 Qualification Lead — Kol Nova"
echo "═══════════════════════════════════════════"
echo ""

# 1. Nom de la clinique
read -p "📋 Nom de la clinique/médecin : " CLINIC_NAME
if [ -z "$CLINIC_NAME" ]; then
  echo "❌ Nom requis." && exit 1
fi

# 2. Ville
read -p "🏙️  Ville : " CITY
CITY=${CITY:-"ירושלים"}

# 3. Ouvrir Google Maps
SEARCH_QUERY=$(echo "$CLINIC_NAME $CITY" | sed 's/ /+/g')
echo "🗺️  Ouverture Google Maps..."
open "https://www.google.com/maps/search/$SEARCH_QUERY" 2>/dev/null

echo ""
echo "→ Regardez les avis Google Maps, puis répondez :"
echo ""

# 4. Note et avis
read -p "⭐ Note Google (ex: 4.2) : " RATING
read -p "📊 Nombre d'avis : " NUM_REVIEWS
read -p "🔑 Mot-clé avis négatif (ex: לא עונים / attente) : " REVIEW_KEY

# 5. Téléphone et site
read -p "📞 Téléphone : " PHONE
read -p "🌐 Site web (ou 'none') : " WEBSITE
WEBSITE=${WEBSITE:-"none"}

# 6. Statut
echo ""
echo "Statut :"
echo "  1) HOT  — tous critères + avis négatifs téléphone"
echo "  2) WARM — 4+ critères, pas d'avis négatifs explicites"
echo "  3) COLD — <4 critères ou booking online existant"
read -p "Statut (1/2/3) : " STATUS_NUM

case $STATUS_NUM in
  1) STATUS="HOT" ;;
  2) STATUS="WARM" ;;
  3) STATUS="COLD" ;;
  *) STATUS="WARM" ;;
esac

DATE=$(date +%Y-%m-%d)

# 7. Écrire dans le CSV
echo "\"$CLINIC_NAME\",\"$PHONE\",\"$WEBSITE\",\"$RATING\",\"$NUM_REVIEWS\",\"$REVIEW_KEY\",\"$CITY\",\"$STATUS\",\"$DATE\"" >> "$CSV_FILE"
echo ""
echo "✅ Lead ajouté au CSV ($STATUS)"

# 8. Générer le message WhatsApp en hébreu
WA_MSG="שלום דקטור, אני דוד מ-DreamNova בירושלים.
שמתי לב למשהו בעמוד גוגל שלכם — נראה שיש לפעמים עומס על הקבלה.
בניתי פתרון שעונה לכל שיחה שנכנסת למרפאה, כולל מחוץ לשעות הפעילות.
הנה דמו של 60 שניות: [LOOM_LINK]
מעוניינים לנסות את זה בשבוע הקרוב?"

# Copier dans le presse-papier (macOS)
echo "$WA_MSG" | pbcopy
echo ""
echo "📋 Message WhatsApp copié dans le presse-papier !"
echo ""
echo "───────────────────────────────────"
echo "$WA_MSG"
echo "───────────────────────────────────"
echo ""

# Ouvrir WhatsApp si numéro disponible
if [ -n "$PHONE" ] && [ "$PHONE" != "none" ]; then
  CLEAN_PHONE=$(echo "$PHONE" | tr -d ' ()-+')
  echo "💬 Pour envoyer : wa.me/$CLEAN_PHONE"
  read -p "Ouvrir WhatsApp ? (o/n) : " OPEN_WA
  if [ "$OPEN_WA" = "o" ]; then
    WA_ENCODED=$(python3 -c "import urllib.parse; print(urllib.parse.quote('''$WA_MSG'''))" 2>/dev/null || echo "")
    if [ -n "$WA_ENCODED" ]; then
      open "https://wa.me/$CLEAN_PHONE?text=$WA_ENCODED"
    else
      open "https://wa.me/$CLEAN_PHONE"
    fi
  fi
fi

echo ""
echo "🎯 Lead qualifié ! Total leads : $(tail -n +2 "$CSV_FILE" | wc -l | tr -d ' ')"
echo ""
