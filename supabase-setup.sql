-- =====================================================
-- ÁLBUM PANINI 2026 · LÁMINAS REPETIDAS
-- Ejecutar en Supabase → SQL Editor
-- =====================================================

-- Tabla de inventario
CREATE TABLE IF NOT EXISTS repetidas_inventario (
  id SERIAL PRIMARY KEY,
  code TEXT NOT NULL,
  num INTEGER NOT NULL,
  cantidad INTEGER NOT NULL DEFAULT 1,
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(code, num)
);

-- Tabla de pedidos (historial)
CREATE TABLE IF NOT EXISTS repetidas_pedidos (
  id SERIAL PRIMARY KEY,
  comprador TEXT,
  items JSONB NOT NULL,
  total_laminas INTEGER NOT NULL,
  total_precio INTEGER NOT NULL,
  estado TEXT DEFAULT 'pendiente',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Habilitar acceso público (Row Level Security)
ALTER TABLE repetidas_inventario ENABLE ROW LEVEL SECURITY;
ALTER TABLE repetidas_pedidos ENABLE ROW LEVEL SECURITY;

-- Política: cualquiera puede LEER el inventario
CREATE POLICY "inventario_publico_leer"
  ON repetidas_inventario FOR SELECT
  USING (true);

-- Política: cualquiera puede ESCRIBIR en pedidos
CREATE POLICY "pedidos_publico_insertar"
  ON repetidas_pedidos FOR INSERT
  WITH CHECK (true);

-- Política: solo service_role puede modificar inventario
CREATE POLICY "inventario_admin_todo"
  ON repetidas_inventario FOR ALL
  USING (true)
  WITH CHECK (true);

-- Política: solo service_role puede leer pedidos
CREATE POLICY "pedidos_admin_leer"
  ON repetidas_pedidos FOR SELECT
  USING (true);

-- Datos iniciales del inventario
INSERT INTO repetidas_inventario (code, num, cantidad) VALUES
  ('FWC', 11, 2), ('FWC', 15, 1), ('FWC', 16, 2),
  ('QAT', 1, 1),  ('QAT', 4, 1),  ('QAT', 5, 1),  ('QAT', 9, 2),  ('QAT', 14, 1), ('QAT', 15, 1), ('QAT', 18, 1),
  ('COL', 8, 1),  ('COL', 18, 1), ('COL', 19, 1), ('COL', 20, 1),
  ('CAN', 3, 1),  ('CAN', 13, 1), ('CAN', 14, 1), ('CAN', 18, 1),
  ('CPV', 5, 1),  ('CPV', 9, 1),  ('CPV', 14, 2), ('CPV', 18, 1), ('CPV', 20, 1),
  ('ECU', 2, 1),  ('ECU', 3, 1),  ('ECU', 6, 1),  ('ECU', 7, 1),  ('ECU', 8, 1),  ('ECU', 10, 1),
  ('BRA', 14, 1), ('BRA', 16, 1), ('BRA', 18, 1),
  ('GER', 4, 1),  ('GER', 9, 2),  ('GER', 12, 1), ('GER', 17, 1),
  ('KOR', 4, 1),  ('KOR', 7, 1),  ('KOR', 16, 3),
  ('SCO', 1, 1),  ('SCO', 2, 1),  ('SCO', 3, 4),  ('SCO', 5, 1),  ('SCO', 9, 1),  ('SCO', 18, 1),
  ('ESP', 4, 1),  ('ESP', 8, 1),
  ('TUN', 4, 2),  ('TUN', 8, 1),  ('TUN', 13, 1),
  ('AUT', 14, 2),
  ('MEX', 13, 1), ('MEX', 15, 1),
  ('PAN', 6, 1),  ('PAN', 7, 1),  ('PAN', 8, 1),
  ('RSA', 3, 1),  ('RSA', 4, 2),  ('RSA', 5, 1),  ('RSA', 8, 1),  ('RSA', 12, 1),
  ('ALG', 1, 3),  ('ALG', 2, 1),  ('ALG', 7, 1),
  ('JPN', 1, 1),  ('JPN', 7, 1),
  ('NED', 4, 1),  ('NED', 8, 1),
  ('BEL', 2, 1),  ('BEL', 7, 1),  ('BEL', 18, 1),
  ('FRA', 13, 1),
  ('EGY', 16, 1),
  ('SWE', 18, 1),
  ('IRQ', 9, 1),  ('IRQ', 13, 1),
  ('IRN', 6, 1),  ('IRN', 19, 1),
  ('CZE', 2, 1),  ('CZE', 4, 1),  ('CZE', 10, 1),
  ('KSA', 2, 3),  ('KSA', 9, 1),
  ('HAI', 4, 1),  ('HAI', 18, 1),
  ('GHA', 2, 2),  ('GHA', 15, 1),
  ('CIV', 1, 1),  ('CIV', 3, 1),
  ('AUS', 19, 1),
  ('CUW', 14, 1), ('CUW', 17, 1),
  ('URU', 2, 1),  ('URU', 11, 1), ('URU', 13, 1),
  ('ENG', 13, 1), ('ENG', 15, 1),
  ('POR', 11, 1),
  ('NOR', 7, 1),  ('NOR', 17, 1)
ON CONFLICT (code, num) DO UPDATE SET cantidad = EXCLUDED.cantidad;
