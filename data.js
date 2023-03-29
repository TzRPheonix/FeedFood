import { MongoClient } from 'mongodb';

let db

export const connectToMongo = async (callback) => {
  const uri = 'mongodb+srv://FeedFoodAdmin:cwsN06hGeHuzwEvd@feedfood.srhefjs.mongodb.net/?retryWrites=true&w=majority';
  const client = new MongoClient(uri);

  try {
    await client.connect();

    db = client.db('test');
    callback()
  } catch (err) {
    console.error(err);
  }
}

export {
    db
}
