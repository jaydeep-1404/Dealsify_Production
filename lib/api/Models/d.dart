 // {
 //   "productionStagesId": "6710c19d7d93a1838d9224c7",
 //   "inspector": "Footwear hub",
 //   "isScrapMaterialEnable": true,
 //   "isAddOnMaterialEnable": false,
 //   "isStageCompleted": false,
 //   "scrapMaterial": [
 //     {
 //       "bomItemId": "6710c19d7d93a1838d9224c1",
 //       "itemId": "6710b829c88e8b449475346e",
 //       "currentStock": 2,
 //       "categoryId": "6710b7c8f4c731c17a2eac66",
 //       "scrapStock": "1"
 //     }
 //   ]
 // }
 // {
 //   "message": "Internal server error!!!",
 //   "stack": "HttpException: Failed to update scrap material!\n    at OrderService.addStageWiseScrapMaterial (/var/task/src/production/order/order.service.js:1251:19)\n    at process.processTicksAndRejections (node:internal/process/task_queues:95:5)\n    at async OrderService.updatePOStages (/var/task/src/production/order/order.service.js:1104:17)\n    at async /var/task/node_modules/@nestjs/core/router/router-execution-context.js:46:28\n    at async /var/task/node_modules/@nestjs/core/router/router-proxy.js:9:17",
 //   "name": "HttpException",
 //   "status": "fail",
 //   "err": "Failed to update scrap material!"
 // }
 //
 //
 // URL : https://dealsify-backend-mongodb.vercel.app/v1/production-order/update-po-stages/6710c19d7d93a1838d9224be
 //