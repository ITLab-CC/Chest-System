const apiPrefix = '/api/v1';
const apiHost = process.env.NEXT_PUBLIC_API_URL || 'http://localhost:8000';
export const apiURL = apiHost + apiPrefix;
