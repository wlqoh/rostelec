import { useParams, useNavigate } from "react-router-dom";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { ArrowLeft, Edit, Plus, FileDown } from "lucide-react";
import { mockBuildings, mockVisits, mockCustomers } from "@/lib/mockData";
import { toast } from "sonner";

export default function ObjectDetail() {
  const { id } = useParams();
  const navigate = useNavigate();
  const building = mockBuildings.find(b => b.id === id);

  if (!building) {
    return (
      <div className="text-center">
        <p className="text-muted-foreground">Объект не найден</p>
        <Button onClick={() => navigate("/_admin/objects")} className="mt-4">
          Вернуться к списку
        </Button>
      </div>
    );
  }

  const buildingVisits = mockVisits.filter(v => v.building === building.address);
  const buildingCustomers = mockCustomers.filter(c => c.building === building.address);

  const handleAction = (action: string) => {
    toast.info(`Демо-режим: ${action}`);
  };

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-start justify-between">
        <div className="space-y-2">
          <Button
            variant="ghost"
            size="sm"
            onClick={() => navigate("/_admin/objects")}
            className="mb-2"
          >
            <ArrowLeft className="mr-2 h-4 w-4" />
            Назад к списку
          </Button>
          <h1 className="text-3xl font-bold">{building.address}</h1>
          <div className="flex flex-wrap gap-2">
            <Badge variant="outline">{building.type}</Badge>
            <Badge>{building.status}</Badge>
            <Badge variant="secondary">{building.city} • {building.district}</Badge>
          </div>
        </div>
        <div className="flex gap-2">
          <Button onClick={() => handleAction("Редактировать")}>
            <Edit className="mr-2 h-4 w-4" />
            Редактировать
          </Button>
          <Button onClick={() => handleAction("Добавить визит")}>
            <Plus className="mr-2 h-4 w-4" />
            Добавить визит
          </Button>
          <Button variant="outline" onClick={() => handleAction("Экспорт по объекту")}>
            <FileDown className="mr-2 h-4 w-4" />
            Экспорт
          </Button>
        </div>
      </div>

      {/* Tabs */}
      <Tabs defaultValue="general" className="w-full">
        <TabsList>
          <TabsTrigger value="general">Общее</TabsTrigger>
          <TabsTrigger value="apartments">Квартиры/Юниты</TabsTrigger>
          <TabsTrigger value="visits">Визиты</TabsTrigger>
          <TabsTrigger value="comments">Комментарии</TabsTrigger>
          <TabsTrigger value="files">Файлы</TabsTrigger>
          <TabsTrigger value="history">История</TabsTrigger>
        </TabsList>

        <TabsContent value="general" className="space-y-4">
          <div className="grid gap-4 md:grid-cols-2">
            <Card>
              <CardHeader>
                <CardTitle>Основная информация</CardTitle>
              </CardHeader>
              <CardContent className="space-y-2">
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Адрес:</span>
                  <span className="font-medium">{building.address}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Город:</span>
                  <span className="font-medium">{building.city}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Район:</span>
                  <span className="font-medium">{building.district}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Тип:</span>
                  <span className="font-medium">{building.type}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Квартир/Юнитов:</span>
                  <span className="font-medium">{building.apartmentsCount || "—"}</span>
                </div>
              </CardContent>
            </Card>

            <Card>
              <CardHeader>
                <CardTitle>Статистика</CardTitle>
              </CardHeader>
              <CardContent className="space-y-2">
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Всего визитов:</span>
                  <span className="font-medium">{building.visitsCount}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Последний визит:</span>
                  <span className="font-medium">{building.lastVisit}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Ответственный:</span>
                  <span className="font-medium">{building.responsible}</span>
                </div>
                <div className="flex justify-between">
                  <span className="text-muted-foreground">Статус:</span>
                  <Badge>{building.status}</Badge>
                </div>
              </CardContent>
            </Card>
          </div>

          {building.gps && (
            <Card>
              <CardHeader>
                <CardTitle>GPS координаты</CardTitle>
              </CardHeader>
              <CardContent>
                <p className="text-sm text-muted-foreground">
                  Широта: {building.gps.lat}, Долгота: {building.gps.lng}
                </p>
                <div className="mt-4 flex h-64 items-center justify-center rounded-lg bg-muted">
                  <p className="text-muted-foreground">Карта (заглушка)</p>
                </div>
              </CardContent>
            </Card>
          )}
        </TabsContent>

        <TabsContent value="apartments">
          <Card>
            <CardHeader>
              <CardTitle>Список квартир/юнитов</CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-center text-muted-foreground">
                Мини-таблица с поиском по номеру (в разработке)
              </p>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="visits">
          <Card>
            <CardHeader>
              <CardTitle>История визитов ({buildingVisits.length})</CardTitle>
            </CardHeader>
            <CardContent>
              {buildingVisits.length === 0 ? (
                <p className="text-center text-muted-foreground">Визиты отсутствуют</p>
              ) : (
                <div className="space-y-4">
                  {buildingVisits.map((visit) => (
                    <div key={visit.id} className="border-b border-border pb-4 last:border-0">
                      <div className="flex items-start justify-between">
                        <div className="space-y-1">
                          <p className="font-medium">{visit.date}</p>
                          <p className="text-sm text-muted-foreground">
                            {visit.engineer} • кв. {visit.apartment}
                          </p>
                          {visit.notes && (
                            <p className="text-sm">{visit.notes}</p>
                          )}
                          {visit.interest.length > 0 && (
                            <div className="flex flex-wrap gap-1">
                              {visit.interest.map((i) => (
                                <Badge key={i} variant="secondary">{i}</Badge>
                              ))}
                            </div>
                          )}
                        </div>
                        <Badge>{visit.status}</Badge>
                      </div>
                    </div>
                  ))}
                </div>
              )}
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="comments">
          <Card>
            <CardHeader>
              <CardTitle>Комментарии</CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-center text-muted-foreground">
                Лента комментариев с формой (в разработке)
              </p>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="files">
          <Card>
            <CardHeader>
              <CardTitle>Файлы</CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-center text-muted-foreground">
                Список файлов (в разработке)
              </p>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="history">
          <Card>
            <CardHeader>
              <CardTitle>История изменений</CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-center text-muted-foreground">
                Аудит-лента изменений (в разработке)
              </p>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
