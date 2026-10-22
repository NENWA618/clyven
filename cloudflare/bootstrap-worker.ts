export default {
  async fetch(): Promise<Response> {
    return new Response("Production bootstrap: not ready", {
      status: 503,
      headers: {
        "Cache-Control": "no-store"
      }
    });
  }
};