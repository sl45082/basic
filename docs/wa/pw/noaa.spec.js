
const { test, expect } = require('@playwright/test');

const { chromium } = require('playwright');

test('capture noaa radar', async ({ page }) => {
 const browser = await chromium.launch({
    headless: true,
    args: ['--kiosk']
  });

  await page.goto('https://www.star.nesdis.noaa.gov/goes/sector_band.php?sat=G19&sector=eus&band=11&length=71&dim=1 &');
  const title = await page.title();
  await page.evaluate(() => {
    window.scrollTo(0, 270); // Scroll down y pixels
  });
  // await page.waitForTimeout(5000); // pauses for 3 second
  await page.screenshot({ path: '/tmp/wa/noaa.png' });

});

