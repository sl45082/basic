
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');

test('capture ventusky', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: ['--kiosk']
  });

  await page.goto('https://embed.ventusky.com/?p=35.4;-79.0;5&l=rain-3h');
  const title = await page.title();
  await page.evaluate(() => {
    window.scrollTo(0, 5); // Scroll down y pixels
  });
  // await page.waitForTimeout(5000); // pauses for 3 second
  await page.screenshot({ path: '/tmp/wa/ventusky.png' });

});

