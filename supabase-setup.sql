-- Jalankan di Supabase > SQL Editor.
create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  category text not null default 'Lainnya',
  price text not null default 'Hubungi kami',
  description text not null default '',
  image_url text not null default '',
  created_at timestamptz not null default now()
);

create table if not exists public.store_settings (
  key text primary key,
  value text not null default ''
);

-- Tabel hanya diakses melalui Netlify Functions menggunakan service role key.
alter table public.products enable row level security;
alter table public.store_settings enable row level security;

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('product-images', 'product-images', true, 5242880,
        array['image/jpeg','image/png','image/webp','image/gif'])
on conflict (id) do update set public = true, file_size_limit = 5242880;
