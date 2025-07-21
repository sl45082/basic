
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');

test('capture accuweather', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: ['--kiosk']
  });

  await page.goto('https://www.accuweather.com/en/us/waves/27982/weather-forecast/2114998');
  const title = await page.title();
  await page.evaluate(() => {
    window.scrollTo(0, 5); // Scroll down y pixels
  });
  // await page.waitForTimeout(5000); // pauses for 3 second
  await page.screenshot({ path: '/tmp/wa/accuweather.png' });

});

