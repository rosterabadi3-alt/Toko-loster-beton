# TUNGGAL ABADI — Netlify + Supabase

Website toko satu halaman dengan panel admin password, upload foto dari perangkat, katalog online, dan WhatsApp.

## Isi paket
- `index.html` — tampilan website dan panel admin.
- `netlify/functions/` — API server-side untuk login, sesi, katalog, pengaturan toko, dan upload foto.
- `netlify.toml` — konfigurasi deploy dan route API.
- `supabase-setup.sql` — skema database dan bucket foto.

## A. Siapkan Supabase (database dan penyimpanan foto)
1. Buat project di https://supabase.com/.
2. Buka **SQL Editor**, tempel isi `supabase-setup.sql`, lalu jalankan.
3. Buka **Project Settings → API**.
4. Salin **Project URL** dan **service_role key**. Jangan pernah masukkan service role key ke `index.html`, GitHub, atau tempat publik.

## B. Upload ke GitHub
1. Buat repository baru, misalnya `tunggal-abadi`.
2. Upload semua isi folder paket ini ke root repository (bukan folder pembungkusnya).
3. Pastikan `index.html`, `netlify.toml`, `supabase-setup.sql`, dan folder `netlify/functions` berada di root.

## C. Hubungkan Netlify
1. Di Netlify pilih **Add new site → Import an existing project**.
2. Hubungkan repository GitHub.
3. Build command boleh dikosongkan; publish directory isi `.`.
4. Sebelum deploy, buka **Site configuration → Environment variables** dan tambahkan:

| Variable | Value |
|---|---|
| `ADMIN_PASSWORD` | `445596` (disarankan ganti sebelum website publik) |
| `SESSION_SECRET` | string acak panjang minimal 32 karakter |
| `SUPABASE_URL` | Project URL dari Supabase |
| `SUPABASE_SERVICE_ROLE_KEY` | service_role key dari Supabase |

5. Simpan variable, lalu deploy/redeploy site.

Untuk membuat `SESSION_SECRET`, bisa gunakan password manager atau generator acak tepercaya. Jangan gunakan contoh atau membagikan nilainya.

## D. Mengelola toko
1. Buka URL Netlify.
2. Klik tombol **Admin** di kanan bawah.
3. Masukkan password admin yang disimpan di environment variable Netlify.
4. Upload logo, edit identitas toko, tambah/edit/hapus produk.
5. Foto dapat dipilih langsung dari galeri HP/komputer (JPG, PNG, WEBP, GIF; maksimal 5 MB).

## Catatan keamanan dan operasional
- Password diverifikasi di Netlify Function; tidak ditanam di HTML.
- Cookie sesi admin bersifat HttpOnly, Secure, SameSite=Strict dan berlaku 8 jam.
- Service role key hanya digunakan di server function.
- Jangan mengaktifkan akses publik write pada tabel/bucket. API write hanya lewat function yang memeriksa sesi admin.
- Ganti password awal `445596` dengan password unik yang lebih kuat sebelum website diumumkan.
- Jika password atau session secret diganti di Netlify, lakukan redeploy.
- Produk, pengaturan, dan foto disimpan online di Supabase; perubahan akan terlihat oleh semua pengunjung.
- Checkout saat ini diarahkan ke WhatsApp toko `087840507473`. Ini bukan payment gateway otomatis.
- Paket ini memerlukan koneksi internet dan akun Supabase + Netlify. Saya belum menghubungkan akun atau melakukan deploy ke akun Anda.

## Troubleshooting
- **Katalog tidak muncul:** periksa environment variables, jalankan SQL setup, dan lihat Netlify Function logs.
- **Login gagal:** pastikan `ADMIN_PASSWORD` dan `SESSION_SECRET` di Netlify sudah diisi, lalu redeploy.
- **Upload gagal:** pastikan bucket `product-images` sudah dibuat oleh SQL setup dan service role key benar.
