
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');

test('capture weather', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: ['--kiosk']
  });

  await page.goto('https://s.w-x.co/staticmaps/severe_us_1280x720.jpg?crop=16:9&width=1200&format=pjpg&auto=webp&quality=100');
  const title = await page.title();
  await page.evaluate(() => {
    window.scrollTo(0, 5); // Scroll down y pixels
  });
  // await page.waitForTimeout(5000); // pauses for 3 second
  await page.screenshot({ path: '/tmp/wa/weather.png' });

});

