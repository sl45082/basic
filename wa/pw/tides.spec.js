
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');

test('capture tide', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: [
	'--kiosk',
	'--window-size=1920,1080'
    ]
  });

  await page.goto('https://www.tide-forecast.com/locations/Oregon-Inlet-North-Carolina/tides/latest');
  const title = await page.title();
  await page.evaluate(() => {
    window.scrollTo(0, 375); // Scroll down y pixels
  });
  // await page.waitForTimeout(5000); // pauses for 3 second
  await page.screenshot({ path: '/tmp/wa/tides.png' });

});

