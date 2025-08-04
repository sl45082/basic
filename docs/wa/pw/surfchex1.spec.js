
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');

test('capture surfchex1', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: [
	'--kiosk',
	'--window-size=1920,1280'
    ]
  });

// html page with everything: https://surfchex.intelliweather.net/imagery/Surfchex/rad_nc_moreheadcity_640x480.htm
// the last image in animation: https://surfchex.intelliweather.net/imagery/Surfchex/rad_nc_moreheadcity_640x480_12.jpg
  await page.goto('https://surfchex.intelliweather.net/imagery/Surfchex/rad_nc_moreheadcity_640x480_12.jpg', {
    waitUntil: 'networkidle',
    timeout: 60000  // prob dont need this
  });

  const title = await page.title();

  await page.evaluate(() => {
    window.scrollTo(0, 3); // Scroll down y pixels
    document.body.style.zoom = '1.0'; // no mag
  });
  // await page.waitForTimeout(5000); // pauses for 3 second
  //await page.screenshot({ path: '/tmp/wa/surfchex1.png' });

  await page.screenshot({
    path: '/tmp/wa/surfchex1.png',
    clip: {
     x: 0,       // horizontal offset from top-left
     y: 0,       // vertical offset from top-left
     width: 1920,   // width of the screenshot
     height: 1280   // height of the screenshot
  }
});


});

