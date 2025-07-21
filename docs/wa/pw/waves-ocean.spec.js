
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');

test('capture waves-ocean surf', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: [
	'--kiosk',
        '--autoplay-policy=no-user-gesture-required',
        '--use-fake-ui-for-media-stream',
        '--use-fake-device-for-media-stream',
        '--disable-gpu',
        '--mute-audio'
    ]
  });

  await page.goto('https://www.surfchex.com/cams/waves-nc-oceanside/');
  const title = await page.title();
  //await page.evaluate(() => {
  //  window.scrollTo(0, 100); // Scroll down y pixels
  //});
  // await page.waitForTimeout(5000); // pauses for 3 second
  await page.screenshot({ path: '/tmp/wa/waves-ocean.png' });

});

