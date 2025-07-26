
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

  await page.goto('https://www.windy.com/35.241/-75.558?35.082,-75.460,8', {
    waitUntil: 'networkidle',
    timeout: 60000  // prob dont need this
  });

  const title = await page.title();

  await page.evaluate(() => {
    window.scrollTo(0, 100); // Scroll down y pixels
    document.body.style.zoom = '1.5'; // 1.5x mag
  });

  await page.waitForTimeout(5000); // pauses for 3 second
//  await page.waitForSelector('div.jw-marker.t1.p1.marker[title="Avon Sound"]', {
//    state: 'visible',
//    timeout: 60000 // optional timeout (10 seconds)
//  });
 
  await page.screenshot({ path: '/tmp/wa/ikite.png' });

});

