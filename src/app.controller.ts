import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { HealthCheck } from '@nestjs/terminus';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('health')
  @HealthCheck()
  getHealth() {
    return this.appService.getHealth();
  }

  @Get()
  getHello() {
    return this.appService.getHello();
  }
}
