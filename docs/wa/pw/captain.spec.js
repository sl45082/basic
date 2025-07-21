
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');

test('capture captain', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: ['--kiosk']
  });

  await page.goto('https://surfcaptain.com/forecast/rodanthe-north-carolina');
  const title = await page.title();
  await page.evaluate(() => {
    window.scrollTo(0, 5); // Scroll down y pixels
  });
  // await page.waitForTimeout(5000); // pauses for 3 second
  await page.screenshot({ path: '/tmp/wa/captain.png' });

});

