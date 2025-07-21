
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');

test('capture surfchex1', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: [
	'--kiosk',
	'--window-size=1920,1080'
    ]
  });


  await page.goto('https://surfchex.intelliweather.net/imagery/Surfchex/rad_nc_moreheadcity_640x480.htm', {
    waitUntil: 'networkidle',
    timeout: 60000  // prob dont need this
  });

  const title = await page.title();

  await page.evaluate(() => {
    window.scrollTo(0, 3); // Scroll down y pixels
    document.body.style.zoom = '2.0'; // 2x mag
  });
  // await page.waitForTimeout(5000); // pauses for 3 second
  await page.screenshot({ path: '/tmp/wa/surfchex1.png' });

});

