
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');

test('capture ikite', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: [
	'--kiosk',
	'--window-size=1920,1080'
    ]
  });

  await page.goto(' https://wx.ikitesurf.com/search/35.158/-75.282/8', {
    waitUntil: 'networkidle',
    timeout: 60000  // prob dont need this
  });

  const title = await page.title();

  await page.evaluate(() => {
    window.scrollTo(0, 3); // Scroll down y pixels
    document.body.style.zoom = '1.5'; // 1.5x mag
  });
  // await page.waitForTimeout(5000); // pauses for 3 second
  await page.screenshot({ path: '/tmp/wa/ikite.png' });

});

