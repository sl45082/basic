
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');

test('capture surfchex2', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: [
	'--kiosk',
	'--window-size=1920,1200'
    ]
  });

// the full html page: 'https://surfchex.intelliweather.net/imagery/Surfchex/satrad_reg_640x480.htm'
// the last image in animation: https://surfchex.intelliweather.net/imagery/Surfchex/satrad_reg_640x480_12.jpg
  await page.goto('https://surfchex.intelliweather.net/imagery/Surfchex/satrad_reg_640x480_12.jpg', {
    waitUntil: 'networkidle',
    timeout: 60000  // prob dont need this
  });
  const title = await page.title();
  await page.evaluate(() => {
    window.scrollTo(0, 5); // Scroll down y pixels
    document.body.style.zoom = '1.0'; // no mag
  });
  // await page.waitForTimeout(5000); // pauses for 3 second
  await page.screenshot({ 
    path: '/tmp/wa/surfchex2.png',
    clip: {
     x: 0,       // horizontal offset from top-left
     y: 0,       // vertical offset from top-left
     width: 1920,   // width of the screenshot
     height: 1080   // height of the screenshot
  }
 });

});

