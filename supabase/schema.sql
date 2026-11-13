-- Diário do Shape: estrutura do banco no Supabase
-- Cole tudo no SQL Editor do seu projeto e clique em Run.

-- Cada registro do app (perfil, pesagens, treinos, dias de comida, alimentos cadastrados)
-- fica numa linha, separado por usuário.
create table if not exists public.docs (
  user_id    uuid        not null references auth.users(id) on delete cascade,
  id         text        not null,
  data       jsonb       not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, id)
);

-- Segurança: cada pessoa só lê e escreve os próprios dados.
alter table public.docs enable row level security;

drop policy if exists "ler os proprios"      on public.docs;
drop policy if exists "inserir os proprios"  on public.docs;
drop policy if exists "atualizar os proprios" on public.docs;
drop policy if exists "apagar os proprios"   on public.docs;

create policy "ler os proprios"       on public.docs for select using (auth.uid() = user_id);
create policy "inserir os proprios"   on public.docs for insert with check (auth.uid() = user_id);
create policy "atualizar os proprios" on public.docs for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "apagar os proprios"    on public.docs for delete using (auth.uid() = user_id);

-- Exclusão de conta pelo próprio app (exigência da Apple e do Google).
-- Apaga o usuário; os registros dele somem junto (on delete cascade).
create or replace function public.excluir_conta()
returns void
language plpgsql
security definer
set search_path = ''
as $$
begin
  delete from auth.users where id = auth.uid();
end;
$$;

revoke all on function public.excluir_conta() from public, anon;
grant execute on function public.excluir_conta() to authenticated;
