import { query, mutation } from "./_generated/server";

export const get = query({
  args: {},
  handler: async (ctx) => {
    return await ctx.db.query("exercises").collect();
  },
});

export const add = mutation(async ({ db }, args) => {
  const { exercise, equipment, muscle_group, notes, video_link } = args;
  await db.insert("exercises", {
    exercise,
    equipment,
    muscle_group,
    notes,
    video_link
  });
});