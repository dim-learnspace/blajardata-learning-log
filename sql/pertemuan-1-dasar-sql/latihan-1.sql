-- ==========================================
-- PERTEMUAN 1: DASAR SQL MENGGUNAKAN BIGQUERY
-- Bootcamp Practical Data Analyst - blajardata
-- ==========================================

-- Struktur Dasar Query:
-- SELECT -> FROM -> WHERE -> ORDER BY -> LIMIT
--
-- Contoh Penulisan:
-- SELECT kolom1, kolom2
-- FROM `project.dataset.nama_tabel`
-- WHERE kondisi
-- ORDER BY kolom1 DESC
-- LIMIT 5;

-- [ 1.1 ] EKSPLORASI TABEL THELOOK E-COMMERCE

-- 1.1A. Siapa saja yang mendaftar pada TheLook?
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.users`
LIMIT 5;

-- 1.1B. Siapa pelanggan yang sudah memesan di TheLook?
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.orders`
LIMIT 5;

-- 1.1C. Barang apa saja yang dipesan? (1 baris = 1 barang)
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.order_items`
LIMIT 5;

-- 1.1D. Melihat katalog produk
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.products`
LIMIT 5;

-- 1.1E. Melihat stok barang di gudang
SELECT *
FROM `bigquery-public-data.thelook_ecommerce.inventory_items`
LIMIT 5;

-- [ 1.2 ] SELECT DAN ORDER

-- 1.2A. Pilih kolom yang dibutuhkan (lebih hemat)
SELECT
  name,
  brand,
  category,
  retail_price
FROM `bigquery-public-data.thelook_ecommerce.products`
LIMIT 10;

-- 1.2B. Apa produk yang paling mahal?
SELECT
  name,
  brand,
  category,
  retail_price
FROM `bigquery-public-data.thelook_ecommerce.products`
ORDER BY retail_price DESC
LIMIT 10;

-- [ 1.3 ] ALIAS

-- 1.3A. Menggunakan alias (AS) agar lebih mudah dibaca
SELECT
  name AS nama_produk,
  retail_price AS harga_usd
FROM `bigquery-public-data.thelook_ecommerce.products`
ORDER BY retail_price DESC
LIMIT 10;

-- [ 1.4 ] NILAI UNIK

-- 1.4A. Kategori apa saja yang ada di toko?
SELECT DISTINCT category
FROM `bigquery-public-data.thelook_ecommerce.products`
ORDER BY category;

-- [ 1.5 ] MEMFILTER BARIS

-- 1.5A. Semua produk dari kategori jeans, dimulai dari yang termahal
SELECT
  name,
  brand,
  retail_price
FROM `bigquery-public-data.thelook_ecommerce.products`
WHERE category = 'Jeans'
ORDER BY retail_price DESC;

-- 1.5B. Produk pria dengan harga di atas 100
SELECT
  name,
  category,
  retail_price
FROM `bigquery-public-data.thelook_ecommerce.products`
WHERE department = 'Men'
  AND retail_price > 100
ORDER BY retail_price DESC
LIMIT 10;

-- 1.5C. Pelanggan dari Jepang dan Prancis
SELECT
  first_name,
  last_name,
  age,
  country
FROM `bigquery-public-data.thelook_ecommerce.users`
WHERE country IN ('Japan', 'France')
LIMIT 20;

-- 1.5D. Pelanggan usia 18 - 24 tahun
SELECT
  first_name,
  last_name,
  age,
  country
FROM `bigquery-public-data.thelook_ecommerce.users`
WHERE age BETWEEN 18 AND 24
LIMIT 20;

-- 1.5E. Produk yang mengandung kata Hoodie
SELECT
  name,
  brand,
  retail_price
FROM `bigquery-public-data.thelook_ecommerce.products`
WHERE name LIKE '%Hoodie%'
ORDER BY retail_price DESC
LIMIT 20;

-- 1.5F. Pesanan yang belum dikirim
SELECT
  order_id,
  status,
  created_at,
  shipped_at
FROM `bigquery-public-data.thelook_ecommerce.orders`
WHERE shipped_at IS NULL
LIMIT 20;

-- [ 1.6 ] MENGHITUNG PESANAN PER STATUS

-- 1.6A. Status apa saja yang ada?
SELECT DISTINCT status
FROM `bigquery-public-data.thelook_ecommerce.orders`;

-- 1.6B. Ada berapa pesanan yang selesai?
SELECT COUNT(*) AS jumlah_pesanan
FROM `bigquery-public-data.thelook_ecommerce.orders`
WHERE status = 'Complete';

-- 1.6C. Ada berapa pesanan yang dibatalkan?
SELECT COUNT(*) AS jumlah_pesanan
FROM `bigquery-public-data.thelook_ecommerce.orders`
WHERE status = 'Cancelled';

-- [ 1.7 ] HANDS ON
-- 1.7A Tampilkan 5 produk TERMURAH di department Women, kategori Dresses
SELECT 
  name,
  brand,
  retail_price
FROM `bigquery-public-data.thelook_ecommerce.products`
WHERE department = 'Women' AND category = 'Dresses'
ORDER BY retail_price ASC
LIMIT 5

-- 1.7B Ada berapa pesanan degan status Returned?
SELECT COUNT(*) AS jumlah_pesanan
FROM `bigquery-public-data.thelook_ecommerce.orders`
WHERE status = 'Returned';

-- [ 1.7 ] LATIHAN MANDIRI

-- L1. Semua produk dari satu brand pilihanmu, urut dari harga tertinggi.
--      (Cari dulu nama brand-nya dengan SELECT DISTINCT brand ...)
-- 1. Mencari Nama Brand
SELECT DISTINCT brand
FROM bigquery-public-data.thelook_ecommerce.products
ORDER BY brand ASC
-- 2. Mencari Produk dari brand pilihan dengan harga tertinggi ke terendah
SELECT *
FROM bigquery-public-data.thelook_ecommerce.products
WHERE brand = 'Alpinestars'
ORDER BY retail_price DESC

-- L2. Pelanggan dari Brasil yang berumur di bawah 25 tahun.
--      (Petunjuk: di dataset ini Brasil ditulis 'Brasil')
SELECT *
FROM bigquery-public-data.thelook_ecommerce.users
WHERE country = 'Brasil' AND age < 25

-- L3. 10 pesanan Returned yang paling baru (urutkan berdasarkan created_at).
SELECT * 
FROM bigquery-public-data.thelook_ecommerce.orders
WHERE status = 'Returned'
ORDER BY created_at DESC
LIMIT 10


-- L4. Produk kategori Sweaters dengan harga 50 sampai 100 USD.
SELECT *
FROM bigquery-public-data.thelook_ecommerce.products
WHERE category = 'Sweaters' AND retail_price BETWEEN 50 AND 100


-- L5. Pelanggan yang datang dari Facebook (kolom traffic_source)
--      dan tinggal di United States. Tampilkan 20 baris.
SELECT *
FROM bigquery-public-data.thelook_ecommerce.users
WHERE traffic_source = 'Facebook' AND country = 'United States'
LIMIT 20

