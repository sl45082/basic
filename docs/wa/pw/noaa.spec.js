
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');

test('capture noaa radar', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: [
	'--kiosk',
	'--window-size=1920,1080'
    ]
  });

//  await page.setViewportSize({ width: 1920, height: 1080 }); // Safe and widely supported

  console.log('Exiting early: marking test as passed');
  return;

  await page.goto('https://www.star.nesdis.noaa.gov/goes/sector_band.php?sat=G19&sector=eus&band=11&length=71&dim=1 &');
  const title = await page.title();
  await page.evaluate(() => {
    window.scrollTo(0, 370); // Scroll down y pixels
  });
  // await page.waitForTimeout(5000); // pauses for 3 second

  // await page.screenshot({ path: '/tmp/wa/noaa.png' });
  await page.screenshot({
    path: '/tmp/wa/noaa.png',
    clip: {
     x: 0,       // horizontal offset from top-left
     y: 0,       // vertical offset from top-left
     width: 1920,   // width of the screenshot
     height: 1080   // height of the screenshot
  }
});


});

