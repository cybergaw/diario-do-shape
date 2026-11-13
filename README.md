# Diário do Shape

App de acompanhamento de peso, bioimpedância, treinos e alimentação, para iPhone e Android.

## Estrutura

- `www/` — o app (HTML, CSS e JavaScript), política de privacidade e termos de uso
- `ios/`, `android/` — projetos nativos gerados pelo Capacitor
- `assets/` — ícone e tela de abertura (os tamanhos de cada plataforma são gerados no build)
- `supabase/schema.sql` — banco de dados, regras de acesso por usuário e exclusão de conta
- `codemagic.yaml` — build na nuvem para App Store e Google Play
- `docs/` — site público com a política de privacidade e os termos (GitHub Pages)
- `loja/` — capturas de tela e imagem de destaque para as lojas

## Configuração

Preencha `www/config.js` com a Project URL e a chave anon do Supabase.
Com o arquivo vazio, o app roda em modo de teste, com os dados só no aparelho.

Para ver o app no computador, abra `www/index.html` no Chrome.

## Versão web para testes

A pasta `docs/app/` é uma cópia de `www/` publicada pelo GitHub Pages em
https://cybergaw.github.io/diario-do-shape/app/ — dá para usar no celular pelo navegador
(e adicionar à tela de início) antes de publicar nas lojas.
Depois de mudar algo em `www/`, rode `npm run web` para atualizar a cópia.

O passo a passo completo de publicação está no "Guia de publicação do Diário do Shape".
