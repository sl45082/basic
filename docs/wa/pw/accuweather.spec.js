
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');


test('capture accuweather', async () => {
  const browser = await chromium.launch({
    headless: true,
    args: ['--kiosk']
  });



  const context = await browser.newContext({
    userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/116.0.0.0 Safari/537.36 Edg/116.0.1938.81',
    viewport: { width: 1280, height: 1024 }
  });

  const page = await context.newPage();

await page.setExtraHTTPHeaders({
  'sec-ch-ua': '"Chromium";v="116", "Not.A/Brand";v="24"',
  'sec-ch-ua-mobile': '?0',
  'sec-ch-ua-platform': '"Windows"'
});


//  console.log('Exiting early: marking test as passed');
 // return;

  await page.goto('https://www.accuweather.com/en/us/waves/27982/weather-forecast/2114998');
  const title = await page.title();
  await page.evaluate(() => {
    window.scrollTo(0, 300); // Scroll down y pixels
  });
  await page.waitForTimeout(5000); // pauses for 3 second
  await page.screenshot({ path: '/tmp/wa/accuweather.png' });

});

