import assert from 'node:assert/strict';
import test from 'node:test';
import { Hsluv } from 'hsluv';
import { Color } from 'three';
import { createServer } from 'vite';

test('HSLuv colors preserve all RGB channels', async () => {
  globalThis.document = { createElement: () => ({}) };
  globalThis.window = { addEventListener: () => {}, navigator: { userAgent: 'node' } };
  const vite = await createServer({
    server: { middlewareMode: true, ws: false },
    appType: 'custom',
    ssr: { noExternal: ['@quatrefoil/utils'] },
  });
  try {
    const { hsluvx } = await vite.ssrLoadModule('/js-out/quatrefoil.core.mjs');
    for (const [h, s, l] of [[0, 100, 50], [120, 100, 50], [240, 100, 50], [0, 0, 50]]) {
      const color = new Hsluv();
      color.hsluv_h = h;
      color.hsluv_s = s;
      color.hsluv_l = l;
      color.hsluvToRgb();
      const expected = new Color().setRGB(color.rgb_r, color.rgb_g, color.rgb_b).getHex();
      assert.equal(hsluvx(h, s, l), expected, `HSLuv(${h}, ${s}, ${l})`);
    }
  } finally {
    await vite.close();
  }
});
