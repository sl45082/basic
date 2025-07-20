

const { test, expect } = require('@playwright/test');


const { chromium } = require('playwright');

test('capture screenshots', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: ['--kiosk']
  });

  await page.goto('https://www.tide-forecast.com/locations/Oregon-Inlet-North-Carolina/tides/latest');
  const title = await page.title();
  await page.evaluate(() => {
    window.scrollTo(0, 300); // Scroll to y pixels
  });
  // await page.waitForTimeout(5000); // pauses for 3 second
  await page.screenshot({ path: '/tmp/tides.png' });
});

