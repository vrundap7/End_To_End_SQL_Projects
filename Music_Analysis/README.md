
---

## 🎵 `Music_answer.sql` — README.md

```markdown
# 🎵 Music Store Database Project (SQL)

This project replicates a digital music store database using MySQL and explores customer behavior,
genre preferences, and invoice trends.

---

## 📌 Objectives

- 🎧 Analyze customer spending and musical taste
- 💸 Calculate revenue by customer, artist, and genre
- 🌍 Understand popularity by country
- 🧠 Use advanced SQL (CTEs, window functions)

---

## 🗂️ Schema Overview

The database contains 11 interconnected tables:
- `track`, `album`, `artist`, `genre`, `media_type`
- `playlist`, `playlist_track`
- `employee`, `customer`, `invoice`, `invoice_line`

---

## 🧪 Query Levels

- ✅ **Easy:** Top spenders, invoice stats
- ⚙️ **Moderate:** Rock music listeners, top rock artists, long tracks
- 🧠 **Advanced:** 
  - Most popular genre by country
  - Top spender per country
  - Artist-wise revenue per customer

---

## 🛠️ How to Use

1. Create the database:
   ```sql
   CREATE DATABASE MUSIC;
   USE MUSIC;
