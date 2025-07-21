
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');

test('capture surfchex2', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: ['--kiosk']
  });

  await page.goto('https://surfchex.intelliweather.net/imagery/Surfchex/satrad_reg_640x480.htm');
  const title = await page.title();
  await page.evaluate(() => {
    window.scrollTo(0, 5); // Scroll down y pixels
  });
  // await page.waitForTimeout(5000); // pauses for 3 second
  await page.screenshot({ path: '/tmp/wa/surfchex2.png' });

});

