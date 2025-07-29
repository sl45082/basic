
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

  await page.setViewportSize({ width: 1920, height: 1080 }); // Safe and widely supported

  await page.goto('https://www.windy.com/35.305/-74.641?34.749,-72.942,8', {
    waitUntil: 'networkidle',
    timeout: 120000  // prob dont need this
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
 
  //await page.screenshot({ path: '/tmp/wa/ikite.png' });
  await page.screenshot({
    path: '/tmp/wa/ikite.png',
    clip: {
     x: 0,       // horizontal offset from top-left
     y: 0,       // vertical offset from top-left
     width: 1920,   // width of the screenshot
     height: 1080   // height of the screenshot
  }
});


});

