# ⚽ Láminas Panini 2026 · laminas.scorevision.space

App web para vender láminas repetidas del álbum Panini FIFA World Cup 2026.

---

## Archivos del proyecto

```
├── index.html          → Tienda pública para compradores
├── admin.html          → Panel admin (PIN protegido)
├── supabase-setup.sql  → Script para crear las tablas
└── README.md           → Este archivo
```

---

## PASO 1 — Configurar Supabase

1. Abre tu proyecto en [supabase.com](https://supabase.com)
2. Ve a **SQL Editor** → **New query**
3. Pega todo el contenido de `supabase-setup.sql`
4. Haz clic en **Run**
5. Confirma que se crearon las tablas `repetidas_inventario` y `repetidas_pedidos`

### Obtener las credenciales

1. En Supabase → **Project Settings** → **API**
2. Copia:
   - **Project URL** → `https://xxxx.supabase.co`
   - **anon / public key** → la clave larga que empieza con `eyJ...`

---

## PASO 2 — Pegar las credenciales en los archivos

Abre `index.html` y busca estas líneas (están cerca al final, en el `<script>`):

```javascript
const SUPABASE_URL = 'REEMPLAZAR_CON_TU_URL';
const SUPABASE_KEY = 'REEMPLAZAR_CON_TU_ANON_KEY';
```

Reemplaza con tus credenciales reales:

```javascript
const SUPABASE_URL = 'https://tuproyecto.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

Haz lo mismo en `admin.html` — tiene las mismas dos líneas.

---

## PASO 3 — Subir a GitHub

1. Crea un repositorio nuevo en GitHub llamado `album-laminas` (privado o público)
2. Sube los 3 archivos: `index.html`, `admin.html`, `supabase-setup.sql`

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/album-laminas.git
git push -u origin main
```

---

## PASO 4 — Deploy en Vercel

1. Ve a [vercel.com](https://vercel.com) → **Add New Project**
2. Importa el repositorio `album-laminas`
3. Configuración:
   - **Framework Preset:** Other
   - **Root Directory:** ./
   - **Build Command:** (dejar vacío)
   - **Output Directory:** (dejar vacío)
4. Haz clic en **Deploy**

---

## PASO 5 — Configurar el subdominio

1. En Vercel → tu proyecto → **Settings** → **Domains**
2. Agrega el dominio: `laminas.scorevision.space`
3. Vercel te dará un registro DNS para agregar
4. Ve a donde administras el dominio `scorevision.space`
5. Agrega el registro CNAME:
   - **Nombre:** `laminas`
   - **Valor:** `cname.vercel-dns.com`
6. Espera 5-10 minutos y listo

---

## URLs finales

| URL | Descripción |
|-----|-------------|
| `https://laminas.scorevision.space` | Tienda pública para compradores |
| `https://laminas.scorevision.space/admin.html` | Panel admin (PIN: 951117) |

---

## Cómo usar el panel admin

1. Abre `laminas.scorevision.space/admin.html`
2. Ingresa el PIN de 6 dígitos
3. Tres secciones disponibles:

### 📦 Inventario
- Ve todas las láminas disponibles en una tabla
- Busca por equipo o número
- Botones `+` y `−` para ajustar cantidad directamente desde la tabla

### ➕ Agregar / Eliminar
- Selecciona el equipo en el desplegable
- Escribe el número de lámina
- **AGREGAR:** suma una copia (si ya existe pasa de ×1 a ×2, etc.)
- **ELIMINAR:** quita una copia (×3 → ×2, ×1 → desaparece)

### 📋 Pedidos
- Historial de pedidos enviados por WhatsApp
- Muestra comprador, láminas, total y fecha

---

## Formatos de número aceptados

| Equipo | Ejemplos válidos |
|--------|-----------------|
| Normal (1–20) | `6`, `13`, `20` |
| Coca-Cola | `CC5`, `CC12`, `5`, `12` |
| FWC | `FWC-03`, `FWC03`, `3` |

---

## Actualizar inventario cuando vendes una lámina

1. Abre `admin.html` → ingresa PIN
2. Tab **Inventario** → busca la lámina → presiona `−`
3. O Tab **Agregar/Eliminar** → selecciona equipo → escribe número → **ELIMINAR**
4. El cambio es inmediato — todos los compradores lo ven en tiempo real

---

## Soporte

Proyecto desarrollado para `scorevision.space`.
