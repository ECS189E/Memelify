import { GraphQLServer } from 'graphql-yoga'
import { Prisma } from './generated/memestatic'
import resolvers from './resolvers'

const server = new GraphQLServer({
  typeDefs: './src/schema.graphql',
  resolvers,
  context: req => ({
    ...req,
    db: new Prisma({
      endpoint: process.env.MEMESTATIC_ENDPOINT, // the endpoint of the MEMESTATIC API (value set in `.env`)
      debug: true, // log all GraphQL queries & mutations sent to the MemeStatic API
      // secret: process.env.MEMESTATIC_SECRETE, // only needed if specified in `database/memestatic.yml` (value set in `.env`)
    }),
  }),
})
server.start(() => console.log(`Server is running on http://localhost:4000`))