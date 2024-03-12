export default defineEventHandler(async (event) => {
    const externalAPI = process.env.API_URL + '/products';
    const apiKey = process.env.X_API_KEY;
  
    try {
      const products = await fetch(externalAPI, {
        headers: {
          'x-api-key': apiKey,
        },
      });
      return products;
    } catch (error) {
      // Handle errors, e.g., by returning an error status and message
      return { error: true, message: 'Failed to fetch products' };
    }
  });