
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');

test('capture cones', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: [
	'--kiosk',
	'--window-size=1920,1080'
    ]
  });

  await page.goto('file:///home/admin/Documents/cones.html', {
    waitUntil: 'networkidle',
    timeout: 60000  // prob dont need this
});

  await page.evaluate(() => {
    window.scrollTo(0, 5); // Scroll down y pixels
  });
  // await page.waitForTimeout(5000); // pauses for 3 second
  await page.screenshot({ path: '/tmp/wa/cones.png' });

});

