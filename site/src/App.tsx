import { Toaster } from "@/components/ui/toaster";
import { Toaster as Sonner } from "@/components/ui/sonner";
import { TooltipProvider } from "@/components/ui/tooltip";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { AdminLayout } from "./components/layouts/AdminLayout";
import { CabinetLayout } from "./components/layouts/CabinetLayout";
import Login from "./pages/auth/Login";
import Dashboard from "./pages/admin/Dashboard";
import Objects from "./pages/admin/Objects";
import ObjectDetail from "./pages/admin/ObjectDetail";
import RoutePage from "./pages/cabinet/Route";
import CabinetObjects from "./pages/cabinet/Objects";
import Profile from "./pages/cabinet/Profile";
import NotFound from "./pages/NotFound";

const queryClient = new QueryClient();

const App = () => (
  <QueryClientProvider client={queryClient}>
    <TooltipProvider>
      <Toaster />
      <Sonner position="top-center" />
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Navigate to="/auth/login" replace />} />
          <Route path="/auth/login" element={<Login />} />
          
          {/* Admin Routes */}
          <Route path="/_admin" element={<AdminLayout />}>
            <Route index element={<Navigate to="/_admin/dashboard" replace />} />
            <Route path="dashboard" element={<Dashboard />} />
            <Route path="objects" element={<Objects />} />
            <Route path="objects/:id" element={<ObjectDetail />} />
            <Route path="visits" element={<div className="p-8 text-center text-muted-foreground">Визиты (в разработке)</div>} />
            <Route path="customers" element={<div className="p-8 text-center text-muted-foreground">Клиенты (в разработке)</div>} />
            <Route path="reports" element={<div className="p-8 text-center text-muted-foreground">Отчёты (в разработке)</div>} />
            <Route path="analytics" element={<div className="p-8 text-center text-muted-foreground">Аналитика (в разработке)</div>} />
            <Route path="users" element={<div className="p-8 text-center text-muted-foreground">Пользователи (в разработке)</div>} />
            <Route path="audit" element={<div className="p-8 text-center text-muted-foreground">Аудит (в разработке)</div>} />
            <Route path="notifications" element={<div className="p-8 text-center text-muted-foreground">Уведомления (в разработке)</div>} />
            <Route path="settings" element={<div className="p-8 text-center text-muted-foreground">Настройки (в разработке)</div>} />
          </Route>

          {/* Cabinet Routes */}
          <Route path="/cabinet" element={<CabinetLayout />}>
            <Route index element={<Navigate to="/cabinet/route" replace />} />
            <Route path="route" element={<RoutePage />} />
            <Route path="objects" element={<CabinetObjects />} />
            <Route path="add" element={<div className="p-8 text-center text-muted-foreground">Добавить (в разработке)</div>} />
            <Route path="customers" element={<div className="p-8 text-center text-muted-foreground">Клиенты (в разработке)</div>} />
            <Route path="profile" element={<Profile />} />
          </Route>

          <Route path="*" element={<NotFound />} />
        </Routes>
      </BrowserRouter>
    </TooltipProvider>
  </QueryClientProvider>
);

export default App;
